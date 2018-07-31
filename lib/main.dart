import 'package:flutter/material.dart';

import 'package:flutter_app/words_list_view.dart';
import 'package:flutter_app/layout.dart';
import 'package:flutter_app/movie_list.dart';
import 'package:flutter_app/grid_view_layout.dart';

void main() => runApp(new MyApp());

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            GridViewLayout(),
            MovieList(),
            RandomWords(),
            Layout(),
          ],
        ),
        bottomNavigationBar: new TabBar(
          isScrollable: false,
          labelColor: Colors.blue,
          tabs: [
            Tab(icon: Icon(Icons.movie)),
            Tab(icon: Icon(Icons.grid_on)),
            Tab(icon: Icon(Icons.list)),
            Tab(icon: Icon(Icons.layers)),
          ]
        )
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}