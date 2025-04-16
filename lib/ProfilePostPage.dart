
import 'package:flutter/material.dart';



class ProfilePostPage extends StatefulWidget{
  final Future<List<dynamic>> posts;
  const ProfilePostPage({super.key, required this.posts});
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
      body: FutureBuilder(
        future: widget.posts,
        builder: (context, snapshot){
          if(snapshot.hasData){
              return ListView(
                children: [
                  for (var post in snapshot.data!)
                    if (post.isNotEmpty)
                      Card(
                        child: ListTile(
                          title: Text(post['user_login']),
                          subtitle: Text(post['message']),
                        ),
                      )
              ],
            );
            }else{
              return const Center(
                child:  Text("Você não tem posts!", style: TextStyle(fontSize: 20.0)),
              );
            }
          }
        )
      );
  }
}