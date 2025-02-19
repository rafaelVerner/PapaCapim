import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => HomePageState();

}

class HomePageState extends State {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),centerTitle: true,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: NavigationBar(destinations:  const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Menssagens',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
          ),
        ],),
      body: <Widget>[
        Card(

        )

      ],
      
      
      
    );
  }
}