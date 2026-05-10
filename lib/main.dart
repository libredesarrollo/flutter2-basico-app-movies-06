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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFFD32F2F),
            secondary: Color(0xFFFF5722),
          ),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
              bodyLarge: TextStyle(fontSize: 14.0),
              bodyMedium: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey[600]))),
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        DetailPage.ROUTE: (_) => DetailPage(movie: MovieModel.empty())
      },
    );
  }
}
