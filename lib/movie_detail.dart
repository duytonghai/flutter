import 'package:flutter/material.dart';

import 'package:flutter_app/constants.dart' as C;

void navigateToDetailPage(BuildContext context, movie) {
  var route = new MaterialPageRoute(
      builder: (BuildContext context) => new MovieDetail(movie: movie)
  );

  Navigator.of(context).push(route);
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
            C.POSTER_HOST + widget.movie['poster_path'],
            fit: BoxFit.cover,
          ),
          titleSection(),
          buildContent()
        ],
      ),
    );
  }
}
