import 'package:movie_challange/src/core/utils/api_info.dart';
import 'package:movie_challange/src/core/utils/data_state.dart';
import 'package:movie_challange/src/data/models/api_pagination_model.dart';

abstract class IRemoteRepository<T> {
  Future<DataState<ApiPaginationModel<T>>> getPaginateData(ApiInfo apiInfo);
  Future<DataState<T>> getSingleData(ApiInfo apiInfo);
}
