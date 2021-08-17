import 'package:flutter/material.dart';
import 'package:webdatos_06/helpers/custo_transition_route.dart';
import 'package:webdatos_06/models/movie_response_model.dart';
import 'package:webdatos_06/movies/detail_page.dart';

class HorizontalMovies extends StatelessWidget {
  final MovieResponseModel movieResponseModel;

  const HorizontalMovies({required this.movieResponseModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.movieResponseModel == null
              ? 0
              : this.movieResponseModel.movies.length,
          itemBuilder: (_, int position) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, DetailPage.ROUTE,
                    //     arguments: this.movieResponseModel.movies[position]);

                      Navigator.push(
                            context,
                            CustomTransitionRoute(
                              curve: Curves.easeInCubic,
                                transtionType: TranstionType.slideRight,
                                widget: DetailPage(
                                    movie: this
                                        .movieResponseModel
                                        .movies[position])));
                  },
                  child: Image.network(this
                      .movieResponseModel
                      .movies[position]
                      .getImagePoster()),
                ),
              ),
            );
          }),
    );
  }
}
