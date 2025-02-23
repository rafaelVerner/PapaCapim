import 'package:flutter/material.dart';

class SingUpPage extends StatefulWidget{
  final Function(int) changePage;
  final Function(String, String, String) singUp;
  const SingUpPage({super.key, required this.changePage, required this.singUp});
  @override
  State<StatefulWidget> createState() => SingUpPageState();

}

class SingUpPageState extends State<SingUpPage>{
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20), child: 
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome de usuário',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => setState(() {
                      name = value;
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                ),
              ),
                Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20), child: 
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => setState(() {
                      email = value;
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20), child:
                TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) => setState(() {
                      password = value;
                    }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                )
              )
            ],
            )
          ),
          Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(10), 
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          widget.singUp(name!, email!, password!);
                          widget.changePage(0);
                        }
                      }, 
                      child: Text("Cadastrar", style: TextStyle(color: Colors.white)))) ,
                  Padding(padding: EdgeInsets.all(10), 
                    child: ElevatedButton( 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          widget.changePage(0);
                        },
                        child: Text("Entrar", style: TextStyle(color: Colors.white))))
                ],
              )
        ],
      ),
    );
  }
}