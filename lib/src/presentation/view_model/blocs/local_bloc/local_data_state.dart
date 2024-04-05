// part of 'api_data_bloc.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../core/error/error.dart';
import '../../../../data/models/movie_model.dart';

part 'local_data_state.freezed.dart';

@freezed
class LocalDataState with _$LocalDataState {
  const factory LocalDataState.idle() = LocalDataIdle;

  const factory LocalDataState.loading() = LocalDataLoading;

  const factory LocalDataState.success({
    required List<MovieModel> data,
  }) = LocalDataSuccess;

  const factory LocalDataState.removeMovie({
    required bool result,
  }) = LocalDataRemoveMovieSuccess;

  const factory LocalDataState.isExist({
    required bool result,
  }) = LocalDataExistMovieSuccess;

  const factory LocalDataState.successStoreMovie({
    required bool result,
  }) = LocalDataStoreMovieSuccess;

  const factory LocalDataState.error({required AppError? error}) = LocalDataError;
}
