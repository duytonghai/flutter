// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Post> fetchPost() async {
//   final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   print(response.statusCode);
//   print(response.body);

//   if (response.statusCode == 200) {
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to load post');
//   }
// }

// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;

//   Post({this.userId, this.id, this.title, this.body});

//   factory Post.fromJson(Map<String, dynamic> json){
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
      await http.get('https://api.themoviedb.org/3/discover/movie?api_key=b56bafdf7dece8d0f38b8d394bc1fb85&sort_by=popularity.desc');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    final int data = json['total_pages'];
    return Post(
      // userId: json['userId'],
      // id: json['id'],
      id: data,
      // body: json['body'],
    );
  }
}

class FloatingButton extends StatelessWidget {

  FloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Custom Theme'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data.id}");
            } else if (snapshot.hasError) {
              print("${snapshot.error}");
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.blue),
        child: FloatingActionButton(
          onPressed: () {
            debugDumpApp();
          },
          child: Icon(Icons.add),
        )
      ),
    );
  }
}