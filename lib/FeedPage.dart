

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'PostPage.dart';

class FeedPage extends StatefulWidget {
  final String url;
  final Future<List<dynamic>> Function() getFeed;
  final String token;
  final Function(int) like;
  final Function(int) dislike;
  final Map<String, dynamic> profile;
  const FeedPage({super.key, required this.url, required this.token, required this.getFeed, required this.like, required this.profile, required this.dislike});

  @override
  State<StatefulWidget> createState() {
    return FeedPageState();
  }
}

class FeedPageState extends State<FeedPage> {
  String search = '';
  final TextEditingController controller = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.getFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                    for (var post in snapshot.data!)
                      if (post.isNotEmpty)
                        if(search == '')
                          Card(
                              child: ListTile(
                            title: Text(post['user_login']!),
                            subtitle: Text(post['message']!),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(map: post,like: widget.like,profile: widget.profile, dislike: widget.dislike,)));
                            },
                          ))
                        else if (post['user_login']!.toString().toLowerCase().contains(search.toLowerCase()) || post['message']!.toString().toLowerCase().contains(search.toLowerCase()))
                          Card(
                              child: ListTile(
                            title: Text(post['user_login']!),
                            subtitle: Text(post['message']!),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(map: post,like: widget.like,profile: widget.profile,dislike: widget.dislike,)));
                            }
                              )
                          )
                    ],
                  )
                )
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 6.0,
              color: Color.fromARGB(255, 91, 212, 64),
            ));
          }
        });
  }
}
