import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:papacapim/LoginPage.dart';
import 'FeedPage.dart';
import 'ProfilePage.dart';
import 'NewPostPage.dart';
import 'SingUpPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPageIndex = 2, index = 0;
  List<Map<String, String>> lista = []; //Isso vai embora
  List<Map<String, String>> profiles = []; //Isso vai sumir tbm
  bool isLoged = false;
  Map<String, String>? profileLoged; // N sei se vou usar isso ainda
  String url = 'https://api.papacapim.just.pro.br';
  String? token;

//Essa função fica
  void goTo(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }



//Essa função fica
  void exit() {
    setState(() {
      profileLoged = {};
      isLoged = false;
    });
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
        });
        
      }

    } catch (e) {
      print('Erro na requisição: $e');
    } finally {
      client.close(); // Sempre bom fechar
    }
  }




  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      LoginPage( changePage: changePage, url: url, login: login),
      ProfilePage(
          changePage: changePage,
          exit: exit,
          lista: lista,
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
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],
      ),
      body: <Widget>[
        FeedPage(lista: lista, url: url, token: token ?? ''),
        NewPostPage(
          key: ValueKey(isLoged),
          goTo: goTo,
          isLoged: isLoged,
          profileLoged: profileLoged ?? {},
        ),
        pages[index]
      ][currentPageIndex.clamp(0, 2)],
    );
  }
}
