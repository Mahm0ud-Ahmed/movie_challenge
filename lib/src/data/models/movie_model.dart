import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  const factory MovieModel({
    required final int id,
    @JsonKey(name: 'backdrop_path')
    final String? image,
    @JsonKey(name: 'original_title')
    required final String title,
    required final String overview,
    required final String releaseDate,
    required final double voteAverage,
    required final int voteCount,
    final List<Map<String, dynamic>>? genres,
    final bool? adult,
    final int? runtime,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

}
