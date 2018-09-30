import 'package:movie_flutter_bloc_pattern/src/models/MovieModel.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final _repository = Repository();

  //whose responsibility
  // is to add the data which it got
  // from the server in form of ItemModel
  // object and pass it to the UI screen as stream
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();
