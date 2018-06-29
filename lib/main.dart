import 'package:flutter/material.dart';

import 'words_list_view.dart';
import 'new_view.dart';

void main() => runApp(new MyApp());

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: new Text('Dito App'),
          bottom: new TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'List View'),
              Tab(text: 'Blank View')
            ]),
        ),
        body: TabBarView(
          children: [
            RandomWords(),
            NewViews(),
          ],
        ),
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
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}