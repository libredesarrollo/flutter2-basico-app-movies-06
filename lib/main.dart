import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdatos_06/helpers/http_helper.dart';
import 'package:webdatos_06/models/movie_model.dart';
import 'package:webdatos_06/models/movie_response_model.dart';
import 'package:webdatos_06/movies/detail_page.dart';
import 'package:webdatos_06/movies/list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  /* myrequest()  {
    HttpHelper.getPopular().then((value) { this.movieResponse = value;});
  }*/

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // myrequest();

    return MaterialApp(
      title: 'Películas',
      initialRoute: ListPage.ROUTE,
      theme: ThemeData(
          primaryColor: Color(0xFFD32F2F),
          accentColor: Color(0xFFFF5722),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              headline1: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
              bodyText1: TextStyle(fontSize: 14.0),
              bodyText2: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey[600]))),
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        DetailPage.ROUTE: (_) => DetailPage(movie: MovieModel.empty())
      },
    );
  }
}
