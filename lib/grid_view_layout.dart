import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String imageHost = 'https://image.tmdb.org/t/p/w370_and_h556_bestv2/';

class GridViewLayout extends StatefulWidget {
  @override
  _GridViewLayoutState createState() => _GridViewLayoutState();
}

class _GridViewLayoutState extends State<GridViewLayout> {
  List data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

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
  
  List<Card> _buildGridCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (data == null || data.isEmpty) {
      return const <Card>[];
    }

    return data.map((movie) {
      final String imageUrl = movie['poster_path'];

      return Card(
      // TODO: Adjust card heights (103)
      child: Column(
        // TODO: Center items on the card (103)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 17 / 12,
            child: new Image.network(imageHost + imageUrl),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
               // TODO: Align labels to the bottom and center (103)
               crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 // TODO: Handle overflowing labels (103)
                 Text(
                    movie['title'],
                    style: theme.textTheme.title,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Search button');
            },
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              print('Filter button');
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu button');
          },
        ),
        title: new Text('Grid View'),
      ),
      body: GridView.count(
        // Specifies how many items across
        crossAxisCount: 2,

        padding: EdgeInsets.all(16.0),

        // Field identifies the size of the items based on an aspect ratio
        childAspectRatio: 8.0 / 9.0,

        children: _buildGridCards(context),
      ),
    );
  }
}
