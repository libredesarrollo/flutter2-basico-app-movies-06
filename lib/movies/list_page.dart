import 'package:flutter/material.dart';
import 'package:webdatos_06/helpers/custo_transition_route.dart';
import 'package:webdatos_06/helpers/http_helper.dart';
import 'package:webdatos_06/models/movie_response_model.dart';
import 'package:webdatos_06/movies/detail_page.dart';

class ListPage extends StatefulWidget {
  static const String ROUTE = "/";

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  MovieResponseModel movieResponseModel = MovieResponseModel.empty();

  ScrollController _scrollController = ScrollController();

  bool _loadData = false;

  Icon _barVisibleIcon = Icon(Icons.search);
  Widget _barSearch = Text("Listado de Películas");

  @override
  void initState() {
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels);
      //print(_scrollController.position.maxScrollExtent);

      if (_scrollController.position.pixels >=
              (_scrollController.position.maxScrollExtent - 50) &&
          !_loadData) {
        _dataList();
      }
    });

    _dataList();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _barSearch,
        actions: [
          IconButton(
              icon: _barVisibleIcon,
              onPressed: () {
                if (this._barVisibleIcon.icon == Icons.search) {
                  this._barVisibleIcon = Icon(Icons.cancel);
                  this._barSearch = TextField(
                    style: TextStyle(color: Colors.white),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (text) {
                      movieResponseModel = MovieResponseModel.empty();
                      _dataList(text: text);
                    },
                  );
                } else {
                  movieResponseModel = MovieResponseModel.empty();
                  this._barVisibleIcon = Icon(Icons.search);
                  this._barSearch = Text("Listado de Películas");
                  _dataList();
                }
                setState(() {});
              })
        ],
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: this.movieResponseModel == null
                    ? 0
                    : this.movieResponseModel.movies.length,
                itemBuilder: (_, int position) {
                  var image;
                  if (this.movieResponseModel.movies[position].posterPath ==
                      null) {
                    image = NetworkImage(
                        "https://st.depositphotos.com/1144687/2206/i/950/depositphotos_22066349-stock-photo-paper-frames.jpg");
                  } else {
                    //image = Image.network(HttpHelper.baseUrlImage + m.posterPath);
                    image = NetworkImage(HttpHelper.baseUrlImage +
                        this.movieResponseModel.movies[position].posterPath);
                  }

                  return Card(
                    elevation: 2.0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: image,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                      title:
                          Text(this.movieResponseModel.movies[position].title),
                      subtitle: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          this.movieResponseModel.movies[position].releaseDate,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(context, DetailPage.ROUTE,
                        //     arguments:
                        //         this.movieResponseModel.movies[position]);

                        // *** Navegacion por defecto
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (_) {
                        //     return DetailPage(
                        //       movie: this.movieResponseModel.movies[position],
                        //     );
                        //   }),
                        // );

                        // *** navegacion con transiciones
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (_, Animation<double> animation,
                        //         Animation<double> animationSecondary) {
                        //       return DetailPage(
                        //         movie: this.movieResponseModel.movies[position],
                        //       );
                        //     },
                        //     transitionsBuilder: (_,
                        //         Animation<double> animation,
                        //         Animation<double> animationSecondary,
                        //         Widget child) {
                        //       // return Align(
                        //       //   alignment: Alignment.topRight,
                        //       //   child: SizeTransition(
                        //       //     sizeFactor: animation, child: child)
                        //       // );

                        //       // return FadeTransition(
                        //       //     opacity: animation, child: child);
                        //       return ScaleTransition(scale:animation,
                        //           child: child);
                        //     },
                        //     transitionDuration: Duration(milliseconds: 500),
                        //     reverseTransitionDuration:
                        //         Duration(milliseconds: 500),
                        //   ),
                        // );

                        // Navigator.push(
                        //     context,
                        //     CustomSizeTransitionRoute(DetailPage(
                        //       movie: this.movieResponseModel.movies[position],
                        //     ),500));

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
                    ),
                  );
                }),
          ),
          Container(
            height: _loadData ? 20 : 0,
            width: 20,
            child: CircularProgressIndicator(),
          )
        ],
      )),
    );
  }

  _dataList({String text = ""}) async {
    _loadData = true;
    setState(() {});

    final movieResponseModelAux = await (_barVisibleIcon.icon == Icons.search
        ? HttpHelper.getPopular(movieResponseModel.page)
        : HttpHelper.getSearch(movieResponseModel.page, text));
    _loadData = false;

    if (movieResponseModelAux != null &&
        movieResponseModelAux.movies.length > 0)
      this.movieResponseModel.movies.addAll(movieResponseModelAux.movies);
    movieResponseModel.page++;

    setState(() {});
  }
}
