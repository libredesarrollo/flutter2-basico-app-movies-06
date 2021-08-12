import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webdatos_06/helpers/http_helper.dart';
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
      routes: {
        ListPage.ROUTE: (_) => ListPage(),
        DetailPage.ROUTE: (_) => DetailPage()
      },
    );
  }
}
