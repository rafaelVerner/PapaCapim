import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  final Function(String, String) login;
  final Function(int) changePage;
  const LoginPage({super.key, required this.login, required this.changePage});
  @override
  State<StatefulWidget> createState() => LoginPageState();

}

class LoginPageState extends State<LoginPage>{
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;
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
                         if (formKey.currentState!.validate()) {
                            formKey.currentState!.save(); 
                            widget.login(email!, password!);
                          }
                        
                      }, 
                      child: Text("Entrar", style: TextStyle(color: Colors.white)))) ,
                  Padding(padding: EdgeInsets.all(10), 
                    child: ElevatedButton( 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          widget.changePage(2);
                        },
                        child: Text("Cadastrar", style: TextStyle(color: Colors.white))))
                ],
              )
        ],
      ),
    );
  }
}