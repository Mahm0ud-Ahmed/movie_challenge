import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_challange/src/presentation/view_model/blocs/data_bloc/api_data_bloc.dart';

import '../../../../core/config/injector.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../data/models/api_pagination_model.dart';
import '../../../../data/repositories/app_repository_imp.dart';
import '../../../../data/repositories/interfaces/i_remote_repository.dart';

class BaseBlocHelper<MODEL> {
  final ApiDataBloc<MODEL> cubit;

  IRemoteRepository<MODEL>? repository;
  PagingController<int, MODEL>? controller;
  ApiInfo? apiInfo;

  BaseBlocHelper({
    required this.cubit,
    this.repository,
    this.apiInfo,
  }) {
    repository = AppRepositoryImp(dioApiService: injector());
    initQueries();
  }

  Map<String, dynamic>? initQueries({ApiInfo? pApiInfo}) {
    apiInfo ??= pApiInfo;
    if (apiInfo != null) {
      Map<String, dynamic> map = {
        'page': apiInfo?.page,
        'append_to_response': apiInfo?.pageSize,
      };
      if (apiInfo!.queries != null && apiInfo!.queries!.isNotEmpty) {
        apiInfo!.queries!.addAll(map);
      } else {
        apiInfo?.queries = map;
      }
      return apiInfo?.queries;
    }
    return null;
  }

  void initializeController() {
    controller = PagingController<int, MODEL>(
      firstPageKey: apiInfo?.queries?['page'],
      invisibleItemsThreshold: apiInfo?.queries?['append_to_response'],
    );
    controller?.removePageRequestListener(_fetchData);
    controller?.addPageRequestListener(_fetchData);
  }

  void _fetchData(int pageKey) {
    apiInfo?.queries?['page'] = pageKey;
    apiInfo?.page = pageKey;
    if (!cubit.isClosed) {
      cubit.getIndexData(info: apiInfo!);
    }
  }

  int? currentPage;

  void newSettingForPagination(ApiPaginationModel<MODEL> pagination) {
    apiInfo?.queries?['page']++;
    bool noMore = _noMoreData(pagination);
    if (noMore) {
      controller?.appendLastPage(pagination.results);
    } else {
      controller?.appendPage(pagination.results, apiInfo?.queries?['page']);
    }
  }

  bool _noMoreData(ApiPaginationModel<MODEL> pagination) {
    return pagination.page >= pagination.totalPages;
    // }
  }
}
