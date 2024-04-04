// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiPaginationModel<MODEL> _$ApiPaginationModelFromJson<MODEL>(
  Map<String, dynamic> json,
  MODEL Function(Object? json) fromJsonMODEL,
) =>
    ApiPaginationModel<MODEL>(
      totalResults: json['total_results'] as int,
      totalPages: json['total_pages'] as int,
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>).map(fromJsonMODEL).toList(),
    );

Map<String, dynamic> _$ApiPaginationModelToJson<MODEL>(
  ApiPaginationModel<MODEL> instance,
  Object? Function(MODEL value) toJsonMODEL,
) =>
    <String, dynamic>{
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'page': instance.page,
      'results': instance.results.map(toJsonMODEL).toList(),
    };
