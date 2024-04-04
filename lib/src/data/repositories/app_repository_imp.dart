// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movie_challange/src/core/utils/data_state.dart';
import 'package:movie_challange/src/data/models/base/api_pagination_model.dart';
import 'package:movie_challange/src/data/repositories/parsing_power.dart';

import '../../core/error/app_exception.dart';
import '../remote/dio_api_service.dart';
import 'i_remote_repository.dart';

class AppRepositoryImp<T> extends IRemoteRepository<T> {
  final DioApiService dioApiService;
  AppRepositoryImp({
    required this.dioApiService,
  });

  @override
  Future<DataState<T>> getSingleData(apiInfo) async {
    try {
      final response = await dioApiService.action(query: apiInfo);
      final responseModel = parseModel<T>(response.data);

      return DataState<T>.success(responseModel);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<ApiPaginationModel<T>>> getPaginateData(apiInfo) async {
    try {
      final response = await dioApiService.action(query: apiInfo);

      final apiResponseParsing = parseModel<ApiPaginationModel>(response.data);
      final responseModel = parseApiPagination<T>(apiResponseParsing);

      return DataState<ApiPaginationModel<T>>.success(responseModel);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }
}
