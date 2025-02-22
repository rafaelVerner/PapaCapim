import 'package:flutter/material.dart';

class PostPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PostPageState();
  }
}

class PostPageState extends State{
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
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text('Nome_Usuário \n', style: TextStyle(fontSize: 18)),),
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0), child: Text('"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eget ligula eu lectus lobortis condimentum. Aliquam nonummy auctor massa. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at risus. Quisque purus magna, auctor et, sagittis ac, posuere eu, lectus. Nam mattis, felis ut adipiscing."'),),
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