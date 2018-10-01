import 'package:flutter/material.dart';
import 'package:movie_flutter_bloc_pattern/src/base/BaseStatefulWidget.dart';
import 'package:movie_flutter_bloc_pattern/src/models/MovieModel.dart';
import 'package:movie_flutter_bloc_pattern/src/resources/movie_detail_bloc_provider.dart';
import 'package:movie_flutter_bloc_pattern/src/ui/MovieRow.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';

class MovieList extends BaseStatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends BaseStatefulWidgetState<MovieList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: buildBody());
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MovieTitle(Colors.redAccent),
            new Expanded(
              child: new ListView.builder(
                  itemCount: snapshot.data.results.length,
                  itemBuilder: (context, index) {
                    return new FlatButton(
                      child: new MovieCell(snapshot.data.results, index),
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {
                        openDetailPage(snapshot.data, index);
                        // Navigator.push(context, new MaterialPageRoute(builder: (context){return new MovieDetail(movies[i]);}));
                      },
                      color: Colors.white,
                    );
                  }),
            )
          ],
        ));


  }

  openDetailPage(ItemModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: data.results[index].title,
            posterUrl: data.results[index].backdrop_path,
            description: data.results[index].overview,
            releaseDate: data.results[index].release_date,
            voteAverage: data.results[index].vote_average.toString(),
            movieId: data.results[index].id,
          ),
        );
      }),
    );
  }

  @override
  buildAppBar() {
    return AppBar(
      elevation: 0.3,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: new Icon(
        Icons.arrow_back,
        color: Colors.redAccent,
      ),
      title: new Text(
        'Movies',
        style: new TextStyle(
            color: Colors.redAccent,
            fontFamily: 'Arvo',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  buildBody() {
    return StreamBuilder(
      stream: bloc.allMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
