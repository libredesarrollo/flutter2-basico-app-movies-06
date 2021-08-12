import 'package:webdatos_06/helpers/http_helper.dart';

class MovieModel {
  int id ;
  String backdropPath ;
  String originalLanguage ;
  String originalTitle ;
  String overview ;
  double popularity ;
  String posterPath ;
  String releaseDate ;
  String title ;
  double voteAverage ;
  int voteCount ;

  MovieModel(
      {required this.id,
      required this.backdropPath,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.voteAverage,
      required this.voteCount});

  getImagePoster() {
    if (this.posterPath == null) {
      return "https://st.depositphotos.com/1144687/2206/i/950/depositphotos_22066349-stock-photo-paper-frames.jpg";
    }
    return HttpHelper.baseUrlImage + this.posterPath;
  }

  MovieModel.fromJson(Map<String, dynamic> movieMap):
    this.id = movieMap['id'],
    this.backdropPath = movieMap['backdrop_path'],
    this.originalLanguage = movieMap['original_language'],
    this.originalTitle = movieMap['original_title'],
    this.overview = movieMap['overview'],
    this.popularity = movieMap['popularity'],
    this.posterPath = movieMap['poster_path'],
    this.releaseDate = movieMap['release_date'] ?? "sin fecha!!!",
    this.title = movieMap['title'],
    this.voteAverage = double.parse(movieMap['vote_average'].toString()),
    this.voteCount = movieMap['vote_count'];
  
}
