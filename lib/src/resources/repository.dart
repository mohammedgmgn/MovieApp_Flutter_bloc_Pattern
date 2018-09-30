import 'dart:async';
import 'package:movie_flutter_bloc_pattern/src/models/MovieModel.dart';
import 'package:movie_flutter_bloc_pattern/src/models/trailer_model.dart';

import 'movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);

}
