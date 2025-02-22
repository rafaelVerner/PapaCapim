import 'package:flutter/material.dart';
import 'FeedPage.dart'; 
import 'ProfilePage.dart';
import 'NewPostPage.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State {
  int currentPageIndex = 0;


  @override
  Widget build(BuildContext context) {
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
        selectedIndex: currentPageIndex,destinations:  const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed),
            label: 'Feed',
          ),NavigationDestination(
            icon: Icon(Icons.dynamic_feed),
            label: 'New Post',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],),
      body: <Widget>[
          FeedPage(),
          NewPostPage(),
          ProfilePage()
      ][currentPageIndex]
      
      
      
    );
  }
}

