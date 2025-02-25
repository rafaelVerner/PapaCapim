import 'package:flutter/material.dart';

class NewPostPage extends StatefulWidget{
  final Function(String, String) newPost;
  final Function(int) goTo;
  final bool  isLoged;
  final Map<String, String> profileLoged;
  const NewPostPage({super.key, required this.newPost, required this.goTo, required this.isLoged, required this.profileLoged});
  
  @override
  State<StatefulWidget> createState() {
    return NewPostPageState();
  }
}

class NewPostPageState extends State<NewPostPage>{
final  GlobalKey<FormState> formKey = GlobalKey<FormState>();
String? post;

@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // Força a reconstrução sempre que a página for aberta
  }

void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); 

      if (post != null && post!.isNotEmpty) {
        widget.newPost(widget.profileLoged['nome']!, post!);
      }
      widget.goTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
     if(widget.isLoged){return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Form(
               key: formKey,
            child: 
              Padding(padding: EdgeInsets.all(10),child: 
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Post',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() {
                    post = value;
                  }),
                ),
              )
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(10), 
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: ()=> _submitForm(), 
                      child: Text("Enviar", style: TextStyle(color: Colors.white)))) ,
                  Padding(padding: EdgeInsets.all(10), 
                    child: ElevatedButton( 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          widget.goTo(0);
                        },
                        child: Text("Cancelar", style: TextStyle(color: Colors.white))))
                ],
              )
          ],

      ),
    );
    }else{
      return Center(
        child: Text('Faça login para postar!', style: TextStyle(fontSize: 20),),
      );       
    }
  }
}