import 'package:flutter/material.dart';

class PostPage extends StatefulWidget{
  final Map<String, String> map;
  const PostPage({super.key, required this.map});
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

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
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(widget.map['nome'] ?? '', style: TextStyle(fontSize: 18)),),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text(widget.map['post'] ?? '')),
                Row(
                children: [
                  Spacer(),
                  IconButton(onPressed: (){
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 30,
                    ), 
                  ),
                  IconButton(onPressed: (){},
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