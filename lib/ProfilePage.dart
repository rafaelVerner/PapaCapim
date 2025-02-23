import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage>{
  String userName = "Usuário Exemplo";
  String userBio = "A vida é uma jornada, aproveite cada momento!";
  

  void editProfile() {
    TextEditingController nameController = TextEditingController(text: userName);
    TextEditingController bioController = TextEditingController(text: userBio);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Perfil"),
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
            ElevatedButton(
              onPressed: editProfile,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Editar Perfil",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}