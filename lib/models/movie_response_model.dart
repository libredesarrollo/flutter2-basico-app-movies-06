import 'package:webdatos_06/models/movie_model.dart';

class MovieResponseModel {
  int page;
  List<MovieModel> movies;

  MovieResponseModel(this.page, this.movies);

  MovieResponseModel.empty():
    this.movies = [],
    this.page = 1;
  

  MovieResponseModel.fromJson(Map<String, dynamic> movieResponseMap) :
    this.page = movieResponseMap["page"],
    this.movies = List<MovieModel>.from(
        movieResponseMap["results"].map((m) => MovieModel.fromJson(m)));
  
}
