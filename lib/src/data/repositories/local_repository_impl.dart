import 'package:movie_challange/src/core/utils/data_state.dart';
import 'package:movie_challange/src/data/local/app_database.dart';
import 'package:movie_challange/src/data/repositories/interfaces/i_local_repository.dart';

import '../../core/error/app_exception.dart';
import '../models/movie_model.dart';

class LocalRepositoryImpl implements LocalAppRepository {
  final AppDatabase appDatabase;

  LocalRepositoryImpl({required this.appDatabase});

  @override
  Future<DataState<bool>> clear() async {
    try {
      final result = await appDatabase.clearMovies();
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<List<MovieModel>>> get() async {
    try {
      final result = appDatabase.getMovies();
      return DataState<List<MovieModel>>.success(
        result.map((e) {
          final Map<String, dynamic> data = {};
          e.forEach((key, value) {
            if (value is List) {
              data[key] = value.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
            } else {
              data[key] = value;
            }
          });
          return MovieModel.fromJson(data);
        }).toList(),
      );
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  DataState<bool> isMovieExist(int id) {
    try {
      final result = appDatabase.isMovieExist(id);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<bool>> removeMovie(int id) async {
    try {
      final result = await appDatabase.deleteMovie(id);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<bool>> store(MovieModel movie) async {
    try {
      final result = await appDatabase.saveMovie(movie);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }
}
