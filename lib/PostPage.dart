import 'package:flutter/material.dart';

class PostPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

class PostPageState extends State{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),centerTitle: true,
        backgroundColor: Color(0xFF1b9400),
        ),
      body: Container(color: Colors.blue,height: 100,width: 100),
      );
  }
}