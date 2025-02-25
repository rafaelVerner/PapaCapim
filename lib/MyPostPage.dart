import 'package:flutter/material.dart';

class MyPostPage extends StatefulWidget{
  final Map<String, String> map;
  const MyPostPage({super.key, required this.map});
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

class PostPageState extends State<MyPostPage>{
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
                    },
                  icon: Icon(Icons.delete), 
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