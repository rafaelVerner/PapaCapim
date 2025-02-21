import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'PostPage.dart';

class FeedPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FeedPageState();
    
  }

}

class FeedPageState extends State{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text("teste"),
            subtitle: Text("data"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PostPage()));
            },
          )
        )
      ],
    );
  }
}