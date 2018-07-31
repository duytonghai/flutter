import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String imageHost = 'https://image.tmdb.org/t/p/w370_and_h556_bestv2/';

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

  void navigateToDetailPage(movie) {
    var route = new MaterialPageRoute(
        builder: (BuildContext context) => new MovieDetail(movie: movie)
    );

    Navigator.of(context).push(route);
  }

  Column buildInfoColumn(Map<String, dynamic> movie) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Container(
          child: new IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.blue,
            ),
            onPressed: () {
              navigateToDetailPage(movie);
            },
          )
        ),
      ],
    );
  }

  Column buildImageColumn(Map<String, dynamic> movie) {
    final String imageUrl = movie['poster_path'];

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new Container(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Image.network(imageHost + imageUrl, width: 80.0),
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
                navigateToDetailPage(movie);
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

class MovieDetail extends StatefulWidget {
  final Map<String, dynamic> movie;

  MovieDetail({Key key, this.movie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  Widget titleSection () {
    return new Container(
      padding: const EdgeInsets.only(top: 10.0, left: 32.0, right: 32.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              // Positions the column to the beginning of the row.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: new Text(
                      widget.movie['title'],
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    'Release date: ${widget.movie['release_date']}',
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ]
            ),
          ),
          new Icon(Icons.star, color: Colors.red[500]),
          new Text(widget.movie['vote_average'].toString()),
        ],
      ),
    );
  }

  Widget buildContent () {
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        widget.movie['overview'],
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Movie Detail'),
      ),
      body: new ListView(
        children: [
          new Image.network(
            imageHost + widget.movie['poster_path'],
            fit: BoxFit.cover,
          ),
          titleSection(),
          buildContent()
        ],
      ),
    );
  }
}
