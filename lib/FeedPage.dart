import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'PostPage.dart';

class FeedPage extends StatefulWidget{
  final List<Map<String, String>> lista;
  const FeedPage({super.key, required this.lista});

  @override
  State<StatefulWidget> createState() {
    return FeedPageState();
  }

}

class FeedPageState extends State<FeedPage>{
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ 
        for(var post in widget.lista)
        if(post.isNotEmpty)
        Card(
          child: ListTile(
            title: Text(post['nome']!),
            subtitle: Text(post['post']!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PostPage(map: post,)));
            },
          )
        )
      ],
    );
  }
}