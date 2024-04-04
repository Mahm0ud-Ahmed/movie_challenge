import 'package:hive/hive.dart';
import 'package:movie_challange/src/core/config/injector.dart';
import 'package:movie_challange/src/core/services/hive_service.dart';

import '../../core/error/app_exception.dart';
import '../models/movie_model.dart';

class AppDatabase {
  late final Box<Map<dynamic, dynamic>> _box;

  Future<bool> saveMovie(MovieModel movie) async {
    try {
      await _box.put(movie.id, movie.toJson());
      return true;
    } catch (e) {
      throw (AppException(e));
    }
  }

  Future<bool> deleteMovie(int id) async {
    try {
      await _box.delete(id);
      return true;
    } catch (e) {
      throw (AppException(e));
    }
  }

  List<Map<String, dynamic>> getMovies() {
    try {
      return _box.values.map<Map<String, dynamic>>((e) => Map.from(e)).toList();
    } catch (e) {
      print(e);
      throw (AppException(e));
    }
  }

  Future<bool> clearMovies() async {
    try {
      await _box.clear();
      return true;
    } catch (e) {
      throw (AppException(e));
    }
  }

  bool isMovieExist(int id) {
    try {
      return _box.containsKey(id);
    } catch (e) {
      throw (AppException(e));
    }
  }

  // singleton
  AppDatabase.init() {
    _box = injector<HiveService>().box;
  }
  static AppDatabase? _instance;
  factory AppDatabase() => _instance ??= AppDatabase.init();
}
