// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_challange/src/data/local/app_database.dart';
import 'package:movie_challange/src/data/repositories/interfaces/i_local_repository.dart';

// Project imports:
import '../../../../core/config/injector.dart';
import '../../../../core/error/error.dart';
import '../../../../core/utils/data_state.dart';
import '../../../../data/models/movie_model.dart';
import '../../../../data/repositories/local_repository_impl.dart';
import 'local_data_state.dart';

class LocalDataBloc extends Cubit<LocalDataState> {
  late final LocalAppRepository localDb;

  LocalDataBloc() : super(const LocalDataIdle()) {
    localDb = LocalRepositoryImpl(appDatabase: injector<AppDatabase>());
  }

  Future<void> getLocalData() async {
    emit(const LocalDataLoading());
    final DataState<List<MovieModel>> dataState = await localDb.get();
    dataState.when(
      success: (successState) {
        emit(LocalDataSuccess(data: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> clearLocalData() async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.clear();
    dataState.when(
      success: (successState) {
        emit(const LocalDataIdle());
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> removeLocalMovie(int id) async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.removeMovie(id);
    dataState.when(
      success: (successState) {
        emit(LocalDataRemoveMovieSuccess(result: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> storeLocalMovie(MovieModel movie) async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.store(movie);
    dataState.when(
      success: (successState) {
        emit(LocalDataStoreMovieSuccess(result: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  DataState<bool> movieIsExist(int id) {
    return localDb.isMovieExist(id);
  }

  void _emitError(
    AppError errorState,
  ) {
    emit(LocalDataError(error: errorState));
  }
}
