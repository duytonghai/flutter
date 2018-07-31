import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app/constants.dart' as C;
import 'package:flutter_app/model/movies.dart';
import 'package:flutter_app/movie_detail.dart';

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
  
  List<Card> _buildGridCards(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (data == null || data.isEmpty) {
      return const <Card>[];
    }

    return data.map((movie) {
      final String imageUrl = movie['poster_path'];

      return Card(
        // TODO: Adjust card heights (103)
        child: new GestureDetector(
          onTap: (){
            navigateToDetailPage(context, movie);
          },
          child: Column(
            // TODO: Center items on the card (103)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 17 / 11,
                child: new Image.network(C.POSTER_HOST + imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
        )
      );
    }).toList();
  }

  Widget _buildBody() {
    if (isLoading) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return GridView.count(
        // Specifies how many items across
        crossAxisCount: 2,

        padding: EdgeInsets.all(16.0),

        // Field identifies the size of the items based on an aspect ratio
        childAspectRatio: 8.0 / 9.0,

        children: _buildGridCards(context),
      );
    }
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
      body: _buildBody()
    );
  }
}
