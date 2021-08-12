import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:webdatos_06/models/movie_response_model.dart';

class HttpHelper {
  static final String key = '?api_key=b12a83ae09383a1f6950a44af3b06212';
  static final String url = 'https://api.themoviedb.org/3/';
  static final String baseUrlImage = 'https://image.tmdb.org/t/p/w500';

  static Future<MovieResponseModel?> getPopular(int page) async {
    final res = await http.get(
      Uri.parse(HttpHelper.url +
        "movie/popular" +
        HttpHelper.key +
        "&page=" +
        page.toString())
    );

    if (res.statusCode == HttpStatus.ok) {
      // exito
      final jsonMap = json.decode(res.body);
      final MovieResponseModel movieResponse =
          MovieResponseModel.fromJson(jsonMap);
      return movieResponse;
    } else {
      // falla
      return null;
    }
  }

  static Future<MovieResponseModel?> getSearch(int page, String text) async {
    final res = await http.get(Uri.parse(HttpHelper.url +
        "search/movie" +
        HttpHelper.key +
        "&page=" +
        page.toString() +
        "&query=" +
        text.toString()));

    if (res.statusCode == HttpStatus.ok) {
      // exito
      final jsonMap = json.decode(res.body);
      final MovieResponseModel movieResponse =
          MovieResponseModel.fromJson(jsonMap);
      return movieResponse;
    } else {
      // falla
      return null;
    }
  }

  static Future<MovieResponseModel?> getTop() async {
    final res =
        await http.get(Uri.parse(HttpHelper.url + "movie/top_rated" + HttpHelper.key));

    if (res.statusCode == HttpStatus.ok) {
      // exito
      final jsonMap = json.decode(res.body);
      final MovieResponseModel movieResponse =
          MovieResponseModel.fromJson(jsonMap);
      return movieResponse;
    } else {
      // falla
      return null;
    }
  }
}
