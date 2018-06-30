import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {

  FloatingButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Custom Theme'),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Text with background color',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(accentColor: Colors.blue),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        )
      ),
    );
  }
}