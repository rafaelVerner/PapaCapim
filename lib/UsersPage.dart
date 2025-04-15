import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget{
  final Future<List<dynamic>> Function() getUsers;
  final String token;
  const UsersPage({super.key, required this.getUsers, required this.token});
  @override
  State<StatefulWidget> createState() {
    return UsersPageState();
  }
}

class UsersPageState extends State<UsersPage>{
  String search = '';
  final TextEditingController controller = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.getUsers(), 
      builder: (context, snapshot){
        if(snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: 
                            TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Pesquisar...",
                                border: InputBorder.none,
                              ),
                          ),   
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              search = controller.text;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: 
                    ListView(
                    children: [
                      for (var user in snapshot.data!)
                        if (user.isNotEmpty)
                          if(search == '')
                            Card(
                                child: ListTile(
                              title: Text(user['login']!),
                              subtitle: Text(user['name']!),
                            ))
                          else if (user['login']!.toString().toLowerCase().contains(search) || user['name']!.toString().toLowerCase().contains(search))
                            Card(
                                child: ListTile(
                                  title: Text(user['login']!),
                                  subtitle: Text(user['name']!),
                      
                                )
                            )
                      ],
                    )
                  )
                ],
          );
        }else{
          return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 6.0,
              color: Color.fromARGB(255, 91, 212, 64),
            ));
        }
        
      }
      );
  }
}