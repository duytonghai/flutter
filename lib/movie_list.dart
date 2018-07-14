import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => new MovieListState();
}

class MovieListState extends State<MovieList> {
  List data;
  bool isLoading = true;

  Future<String> fetchPost() async {
    final response =
    await http.get('https://api.themoviedb.org/3/discover/movie?api_key=b56bafdf7dece8d0f38b8d394bc1fb85&sort_by=popularity.desc');

    Map<String, dynamic> body;

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      body = json.decode(response.body);

      this.setState(() {
        isLoading = false;
        data = body["results"];
      });
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }

    return 'Success!';
  }


  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  Column buildButtonColumn(String imageUrl) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Image.network("https://image.tmdb.org/t/p/w370_and_h556_bestv2/" + imageUrl),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> item = data[index];
          return new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonColumn(item["poster_path"]),
            ],
          );
        }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Movies'),
      ),
      body: _buildBody()
//      floatingActionButton: Theme(
//        data: Theme.of(context).copyWith(accentColor: Colors.blue),
//        child: FloatingActionButton(
//          onPressed: () {
//            debugDumpApp();
//          },
//          child: Icon(Icons.add),
//        )
//      ),
    );
  }
}