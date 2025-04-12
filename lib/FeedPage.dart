import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'PostPage.dart';
import 'package:http/http.dart' as http;

class FeedPage extends StatefulWidget {
  final List<Map<String, String>> lista; //tirar isso aqui depois
  final String url;
  final String token;
  const FeedPage({super.key, required this.lista, required this.url, required this.token});

  @override
  State<StatefulWidget> createState() {
    return FeedPageState();
  }
}

class FeedPageState extends State<FeedPage> {

  
  Future<List<dynamic>> getFeed() async {
    var client = http.Client();
    try {
      http.Response? res = await client.get(
        Uri.parse(widget.url + '/posts'),
        headers: {'x-session-token': widget.token}
      );
      return json.decode(res.body);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var post in snapshot.data!)
                  if (post.isNotEmpty)
                    Card(
                        child: ListTile(
                      title: Text(post['user_login']!),
                      subtitle: Text(post['message']!),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostPage(
                                      map: post,
                                    )));
                      },
                    ))
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
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
