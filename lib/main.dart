import 'package:flutter/material.dart';

import 'package:flutter_app/words_list_view.dart';
import 'package:flutter_app/floating_button.dart';
import 'package:flutter_app/layout.dart';

void main() => runApp(new MyApp());

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            RandomWords(),
            Layout(),
            FloatingButton(),
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