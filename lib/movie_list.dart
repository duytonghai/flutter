import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app/constants.dart' as C;
import 'package:flutter_app/model/movies.dart';
import 'package:flutter_app/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => new MovieListState();
}

class MovieListState extends State<MovieList> {
  List data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<String> fetchData() async {
    if (data == null || data.isEmpty) {
      List movies = await fetchMovies();

      setState(() {
        data = movies;
        isLoading = movies == null || movies.isEmpty;
      });
    }

    return 'Done!';
  }

  // TODO will be removed
//  Column buildInfoColumn(Map<String, dynamic> movie) {
//    return new Column(
//      mainAxisSize: MainAxisSize.max,
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        new Container(
//          child: new IconButton(
//            icon: const Icon(
//              Icons.info,
//              color: Colors.blue,
//            ),
//            onPressed: () {
//              navigateToDetailPage(movie);
//            },
//          )
//        ),
//      ],
//    );
//  }

  Column buildImageColumn(Map<String, dynamic> movie) {
    final String imageUrl = movie['poster_path'];

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Image.network(C.POSTER_HOST + imageUrl, width: 80.0),
        )
      ],
    );
  }

  Expanded buildTitleColumn(Map<String, dynamic> movie) {
    return new Expanded(
      child: new Container(
        padding: const EdgeInsets.only(left: 10.0),
        child: new Text(
          movie['title'],
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: new TextStyle(
            fontSize: 15.0,
            fontFamily: 'Roboto',
            color: new Color(0xFF212121),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
          Map<String, dynamic> movie = data[index];
          return new Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: new GestureDetector(
              onTap: (){
                navigateToDetailPage(context, movie);
              },
              child: new Row(
                children: [
                  buildImageColumn(movie),
                  buildTitleColumn(movie),
                ],
              ),
            )
          );
        },
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
