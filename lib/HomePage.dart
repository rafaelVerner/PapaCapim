import 'package:flutter/material.dart';
import 'package:papacapim/LoginPage.dart';
import 'FeedPage.dart'; 
import 'ProfilePage.dart';
import 'NewPostPage.dart';
import 'SingUpPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State<HomePage> {
  int currentPageIndex = 0, index = 0;
  List<Map<String, String>> lista = [];
  List<Map<String, String>> profiles = [];
  bool isLoged = false;
  Map<String, String>? profileLoged;

  void goTo(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  void login(String email, String password){
    bool flag = false;
    for(var profile in profiles){
      if(profile['email'] == email && profile['password'] == password ) {
        setState(() {
          index = 1;
          flag = true;
          isLoged = true;
          profileLoged = profile;
        });
      }
    }
    if(!flag){
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Login Inválido!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o alerta
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  } 

  void exit(){
    setState(() {
      profileLoged = {};
      isLoged = false;
    });
  }

  void changePage(int newIndex){
    setState(() {
      index = newIndex;
    });
  }
  
  void singUp(String nome, String email, String password){
    profiles.add({'nome':nome, 'email': email, 'password': password});
  }
  
  void newPost(String nome, String post) => setState(() {
    lista.add({'nome': nome,'post': post});
  });

  List<Map<String, String>> getProfilePost(String nome, List lista){
    List<Map<String, String>> profilePosts = [];
    for(var post in lista){
      if(post['nome'] == nome){
        profilePosts.add(post);
      }
    }
    return profilePosts;
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [LoginPage(login: login, changePage: changePage), ProfilePage( changePage: changePage, exit: exit, getProfilePost: getProfilePost, lista: lista, profile: profileLoged ?? {},), SingUpPage( changePage: changePage, singUp: singUp,)];
    return  Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),centerTitle: true,
        backgroundColor: Color(0xFF1b9400),
      ),
      bottomNavigationBar: NavigationBar(onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 91, 212, 64),
        selectedIndex: currentPageIndex,
        destinations:  const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),NavigationDestination(
            icon: Icon(Icons.add),
            label: 'New Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],),
      body: <Widget>[
          FeedPage(lista: lista),
          NewPostPage(key: ValueKey(isLoged), newPost: newPost, goTo: goTo, isLoged: isLoged, profileLoged: profileLoged ?? {},),
          pages[index]
        ][currentPageIndex.clamp(0, 2)],
      
      
      
    );
  }
}

