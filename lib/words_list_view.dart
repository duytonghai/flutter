import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  void _showSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final items = _saved;
          final tiles = items.map((pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,),
              onTap: () {
                this.setState(() {
                  this._saved.remove(pair);
                });
              },
            );
          });
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Items'),
            ),
            body: new ListView(
              children: divided,
            ),
          );
        },
      )
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // Add a one-pixel-high divider widget before each row in theListView.
        if (i.isOdd) return new Divider();

        /**
         * The syntax "i ~/ 2" divides i by 2 and returns an integer result.
         * For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
         * This calculates the actual number of word pairings in the ListView,
         * minus the divider widgets.
         */
        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRows(_suggestions[index]);
      }
    );
  }

  Widget _buildRows(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont,),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Dito App'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list),
              onPressed: _showSaved
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}