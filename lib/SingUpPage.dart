import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SingUpPage extends StatefulWidget {
  final Function(int) changePage;
  final String url;
  const SingUpPage(
      {super.key,
      required this.changePage,
      required this.url});
  @override
  State<StatefulWidget> createState() => SingUpPageState();
}

class SingUpPageState extends State<SingUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, userName, password, passwordConfirm;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();


  void post(BuildContext context) async {
    var client = http.Client();

    try {
      final resp = await client.post(Uri.parse(widget.url + '/users'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "user": {
              "login": userName,
              "name": name,
              "password": password,
              "password_confirmation": passwordConfirm
            }
          }));
      if(resp.statusCode == 201){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );
        widget.changePage(0);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao cadastrar! Verifique os dados.")),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

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
                        labelText: 'Nome de usuário',
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
                        labelText: 'Nome',
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
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        controller: passwordController,
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
                        obscureText: true,
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: TextFormField(
                        controller: confirmController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar senha',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) => setState(() {
                          passwordConfirm = value;
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }else if(value != passwordController.text){
                            return 'Senhas diferentes!';
                          }
                          return null;
                        },
                        obscureText: true,
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
                      child: Text("Cadastrar",
                          style: TextStyle(color: Colors.white)))),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        widget.changePage(0);
                      },
                      child: Text("Entrar",
                          style: TextStyle(color: Colors.white))))
            ],
          )
        ],
      ),
    );
  }
}
