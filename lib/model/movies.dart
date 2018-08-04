import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_app/constants.dart' as C;

const movieSearchUrl = '${C.API_HOST}/${C.API_VERSION}/discover/movie?sort_by=popularity.desc&${C.API_KEY}';

Future<List> handleData(http.Response response) async {
  List results;
  Map<String, dynamic> body;

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    body = await json.decode(response.body);
    results = body['results'];

    return results;
  } else {
    print('[Error]: ' + response.body);
    // If that call was not successful, throw an error.
    return [];
  }
}

Future<List> fetchMovies() async {
  final response = await http.get(movieSearchUrl);
  final responsePageTwo = await http.get(movieSearchUrl + '&page=2');

  List results = await handleData(response);
  List resultsPageTwo = await handleData(responsePageTwo);

  results = results..addAll(resultsPageTwo);

  return results;
}
