import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:papacapim/LoginPage.dart';
import 'FeedPage.dart';
import 'ProfilePage.dart';
import 'NewPostPage.dart';
import 'SingUpPage.dart';
import 'UsersPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPageIndex = 3, index = 0;
  Map<String, dynamic>? profileLoged; // N sei se vou usar isso ainda
  String url = 'https://api.papacapim.just.pro.br';
  String? token;

/*

      =========Funções=========

*/


//Essa função fica
  void goTo(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

//Essa função fica
  void exit() async{
    var client = http.Client();
    try{
      final response = await client.delete(
        Uri.parse(url + '/sessions/1'),
        headers: {
          'Content-Type': 'application/json',
          'x-session-token': token ?? ''
          }
        );
      
        setState(() {
          profileLoged = {};
          token = '';
        });
      
    }catch(e){
       print('Erro na requisição: $e');
    }
    
  }

//Essa função fica
  void changePage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void login(BuildContext context, String userName, String password) async {
    var client = http.Client();

    try {
      final response = await client.post(
        Uri.parse(url + '/sessions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "login": userName,
          "password": password,
        }),
      );

      if(response.statusCode == 200){
        setState(() {
          token = json.decode(response.body)['token'];
          profileLoged = json.decode(response.body);
        });
        
      }

    } catch (e) {
      print('Erro na requisição: $e');
    } finally {
      client.close();
    }
  }

  Future<List<dynamic>> getFeed() async {
    var client = http.Client();
    try {
      http.Response? res = await client.get(
        Uri.parse(url + '/posts'),
        headers: {'x-session-token': token ?? ''}
      );
      return json.decode(res.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<dynamic>> getUsers() async {
    var client = http.Client();
    try {
      http.Response? res = await client.get(
        Uri.parse(url + '/users'),
        headers: {'x-session-token': token ?? ''}
      );
      return json.decode(res.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

/*

      =========Widgets=========

*/


  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      LoginPage( changePage: changePage, url: url, login: login),
      ProfilePage(
          changePage: changePage,
          exit: exit,
          profile: profileLoged ?? {},),
      SingUpPage(
        changePage: changePage,
        url: url,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF1b9400),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 91, 212, 64),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'New Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.supervised_user_circle_outlined),
            label: 'Usuários',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],
      ),
      body: <Widget>[
        FeedPage(url: url, token: token ?? '', getFeed: getFeed),
        NewPostPage(
          goTo: goTo,
          token: token ?? '',
          profileLoged: profileLoged ?? {},
        ),
        UsersPage(getUsers: getUsers, token: token ?? ''),
        pages[index]
      ][currentPageIndex.clamp(0, 3)],
    );
  }
}
