import 'package:flutter/material.dart';
import 'package:webdatos_06/helpers/http_helper.dart';
import 'package:webdatos_06/models/movie_response_model.dart';

class ListPage extends StatefulWidget {
  static const String ROUTE = "/";

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late List<Widget> widgetMovies;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado Películas"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _dataList(),
          builder: (_, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return ListView.builder(
                itemCount: this.widgetMovies.length,
                itemBuilder: (_, int position) {
                  return this.widgetMovies[position];
                });
          },
        ),
      ),
    );
  }

  Future<List<Widget>> _dataList() async {
    final MovieResponseModel? movieResponseModel =
        await HttpHelper.getPopular(1);

    if (movieResponseModel == null) {
      return [];
    }

    widgetMovies = movieResponseModel!.movies.map((m) {
      var image;
      if (m.backdropPath == null) {
        image = NetworkImage(
            "https://st.depositphotos.com/1144687/2206/i/950/depositphotos_22066349-stock-photo-paper-frames.jpg");
      } else {
        //image = Image.network(HttpHelper.baseUrlImage + m.posterPath);
        image = NetworkImage(HttpHelper.baseUrlImage + m.posterPath);
      }

      return Card(
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: image,
          ),
          title: Text(m.title),
        ),
      );
    }).toList();

    return widgetMovies;
  }
}
