

import 'package:flutter/material.dart';



class ProfilePostPage extends StatefulWidget{
  final Future<List<dynamic>> posts;
  final Function(int) deletePost;
  const ProfilePostPage({super.key, required this.posts, required this.deletePost});
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
                        child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(post['user_login'] ?? '', style: TextStyle(fontSize: 18)),),
                            Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(post['message'] ?? '')),
                            Row(
                            children: [
                              Spacer(),
                              IconButton(
                                onPressed: (){
                                showDialog(context: context,
                                  builder: (context){
                                      return AlertDialog(
                                        title: const Text("Deseja deletar o post?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              widget.deletePost(post['id']);//Cuidado com isso aqui, vai acabar com o papacapim
                                              Navigator.pop(context);
                                            },
                                              child: const Text("Sim", style: TextStyle(color: Colors.green)),
                                            ),
                                        ],
                                    );
                                  });
                                },
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                ), 
                              ),
                              
                            ],
                        )]),
                ),
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