import 'package:flutter/material.dart';

import 'ProfilePostPage.dart';

class ProfilePage extends StatefulWidget{
  final Function(int) changePage;
  final Function() exit;
  final Function(String, List) getProfilePost;
  final List<Map<String, String>> lista;
  final Map<String, String> profile;
  const ProfilePage({super.key, required this.changePage, required this.exit, required this.getProfilePost, required this.lista, required this.profile, });

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage>{
  String userName = "Usuário Exemplo";
  String userBio = "A vida é uma jornada, aproveite cada momento!";
  String userEmail = "exemplo_email@papacapim.com";
  String userSenha = "********";

  void editProfile() {
    TextEditingController nameController = TextEditingController(text: userName);
    TextEditingController bioController = TextEditingController(text: userBio);
    TextEditingController emailController = TextEditingController(text: userEmail);
    TextEditingController senhaController = TextEditingController(text: userSenha);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Perfil", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.grey[900],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
              TextField(
                controller: bioController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Bio",
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
                TextField(
                controller: senhaController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white54),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                  userBio = bioController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Salvar", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil do Usuário"), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage("https://s3.amazonaws.com/media.wikiaves.com.br/images/6461/1646306_aa8b69712e4306430b3e36bfbed09e0a.jpg"),
            ),
            const SizedBox(height: 10),
            Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(userBio, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: editProfile,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Editar Perfil",style: TextStyle(color: Colors.white),),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0))
                ,
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePostPage(posts: widget.getProfilePost(widget.profile['nome']!, widget.lista))));
                }, 
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Meus posts",style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            
            Padding(padding: EdgeInsets.all(10)),
             ElevatedButton(
              onPressed: (){
                widget.exit();
                widget.changePage(0);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text("Sair",style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      ),
    );
  }
}