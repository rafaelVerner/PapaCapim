import 'package:flutter/material.dart';

class PostPage extends StatefulWidget{
  final Map<String, dynamic> map;
  final Function(int) like;
  final Function(int) dislike;
  final Map<String, dynamic> profile;
  const PostPage({super.key, required this.map, required this.like, required this.profile, required this.dislike});
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

//Nessa página precisa modificar o botão de like e o botão de responder a mensagem
//Bom crira uma collun com outra list view para colocar as respostas do post em baixo dele

class PostPageState extends State<PostPage>{
  bool isLiked = false;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PapaCapim', style: TextStyle(color: Colors.white)),centerTitle: true,
        backgroundColor: Color(0xFF1b9400),
        ),
      body: ListView(
        children: [
          Card(
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(widget.map['user_login'] ?? '', style: TextStyle(fontSize: 18)),),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(widget.map['message'] ?? '')),
                Row(
                children: [
                  Spacer(),
                  IconButton(onPressed: (){
                      isLiked ?widget.like(widget.map['id']) : 
                      
                    },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 30,
                    ), 
                  ),
                  IconButton(onPressed: (){
                    },
                  icon: Icon(
                    Icons.send,
                    size: 30,
                    ), 
                  ),
                ],
            )]),
          ),
          
        ],
      ),
      );
  }
}