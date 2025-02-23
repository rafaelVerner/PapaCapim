import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginPageState();

}

class LoginPageState extends State{
  final  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                      labelText: 'Email ou Nome do usuário',
                      border: OutlineInputBorder(),
                    ),
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
                      onPressed: (){}, 
                      child: Text("Cadastrar", style: TextStyle(color: Colors.white)))) ,
                  Padding(padding: EdgeInsets.all(10), 
                    child: ElevatedButton( 
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){},
                        child: Text("Entrar", style: TextStyle(color: Colors.white))))
                ],
              )
        ],
      ),
    );
  }
}