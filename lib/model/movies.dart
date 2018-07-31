import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_app/constants.dart' as C;

const movieSearchUrl = '${C.API_HOST}/${C.API_VERSION}/discover/movie?sort_by=popularity.desc&${C.API_KEY}';

Future<List> fetchMovies() async {
  final response = await http.get(movieSearchUrl);

  Map<String, dynamic> body;

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    body = await json.decode(response.body);

    return body['results'];
  } else {
    print('[Error]: ' + response.body);
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
