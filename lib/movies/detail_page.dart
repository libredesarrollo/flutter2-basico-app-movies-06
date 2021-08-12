import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webdatos_06/helpers/http_helper.dart';
import 'package:webdatos_06/models/movie_model.dart';
import 'package:webdatos_06/widgets/movies/horizontal_movies.dart';

class DetailPage extends StatelessWidget {
  static const ROUTE = "/detail";

  @override
  Widget build(BuildContext context) {
    final MovieModel movie =
        ModalRoute.of(context)!.settings.arguments as MovieModel;

    String pathFull, pathPosted;
    if (movie.backdropPath == null) {
      pathFull =
          "https://st.depositphotos.com/1144687/2206/i/950/depositphotos_22066349-stock-photo-paper-frames.jpg";
    } else {
      pathFull = HttpHelper.baseUrlImage + movie.backdropPath;
    }
    if (movie.posterPath == null) {
      pathPosted =
          "https://st.depositphotos.com/1144687/2206/i/950/depositphotos_22066349-stock-photo-paper-frames.jpg";
    } else {
      pathPosted = HttpHelper.baseUrlImage + movie.posterPath;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(pathFull),
            Card(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            pathPosted,
                            width: 60,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            RatingBar.builder(
                              itemCount: 5,
                              initialRating: movie.voteAverage / 2,
                              allowHalfRating: true,
                              itemSize: 20,
                              itemBuilder: (context, _) {
                                return Icon(Icons.star,
                                    color: Colors.amberAccent);
                              },
                              onRatingUpdate: (_) {},
                              ignoreGestures: true,
                            ),
                            Text(
                              "Votos: " +
                                  (movie.voteAverage / 2).toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                        Text(
                          movie.releaseDate,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600]),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Top 15",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    FutureBuilder(
                      future: HttpHelper.getTop(),
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return HorizontalMovies(
                            movieResponseModel: snapshot.data,
                          );
                        }
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
