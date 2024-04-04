import 'package:movie_challange/src/core/utils/data_state.dart';

import '../models/movie_model.dart';

abstract class LocalAppRepository {
  Future<DataState<bool>> store(MovieModel movie);
  Future<DataState<List<MovieModel>>> get();
  Future<DataState<bool>> removeMovie(int id);
  Future<DataState<bool>> clear();
  DataState<bool> isMovieExist(int id);
}
