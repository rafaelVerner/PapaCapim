import 'package:flutter/material.dart';

class ProfilePostPage extends StatefulWidget{
  const ProfilePostPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

class PostPageState extends State<ProfilePostPage>{
  bool isLiked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),centerTitle: true,
        backgroundColor: Color(0xFF1b9400),
        ),
      body: ListView(
      children: [/* 
        for(var post in widget.posts)
        if(post.isNotEmpty)
        Card(
          child: ListTile(
            title: Text(post['nome']!),
            subtitle: Text(post['post']!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPostPage(map: post, deletePost: widget.deletePost,)));
            },
          )
        )
      */],
      ),
      );
  }
}