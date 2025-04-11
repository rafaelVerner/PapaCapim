import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {  
  final Function(int) changePage;
  final String url;
  const LoginPage(
      {super.key,
      required this.changePage,
      required this.url,});
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  void post(BuildContext context) async {
    var client = http.Client();

    try {
      final response = await client.post(
        Uri.parse(widget.url + '/sessions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "login": userName,
          "password": password,
        }),
      );

    } catch (e) {
      print('Erro na requisição: $e');
    } finally {
      client.close(); // Sempre bom fechar
    }
  }




  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userName, password;
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nome de Usuário',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => setState(() {
                        userName = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
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
                      ))
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          post(context);
                          
                        }
                      },
                      child: Text("Entrar",
                          style: TextStyle(color: Colors.white)))),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        widget.changePage(2);
                      },
                      child: Text("Cadastrar",
                          style: TextStyle(color: Colors.white))))
            ],
          )
        ],
      ),
    );
  }
}
