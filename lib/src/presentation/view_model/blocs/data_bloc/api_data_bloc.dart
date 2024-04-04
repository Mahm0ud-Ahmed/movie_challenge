// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// Project imports:
import '../../../../core/error/error.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../core/utils/data_state.dart';
import '../../../../data/models/base/api_pagination_model.dart';
import '../assistance/base_bloc_helper.dart';
import 'api_data_state.dart';

class ApiDataBloc<MODEL> extends Cubit<ApiDataState<MODEL>> {
  BaseBlocHelper<MODEL>? _helper;
  PagingController<int, MODEL>? get controller => _helper?.controller;
  final ApiInfo? apiInfo;

  ApiDataBloc({this.apiInfo}) : super(const ApiDataIdle()) {
    _helper = BaseBlocHelper<MODEL>(cubit: this, apiInfo: apiInfo);
    if (apiInfo != null) {
      _helper?.initQueries(pApiInfo: apiInfo);
      _helper?.initializeController();
    }
  }

  Future<void> getGeneralData({required ApiInfo info}) async {
    emit(ApiDataLoading<MODEL>());
    final DataState<MODEL> dataState = await _helper!.repository!.getSingleData(info);
    dataState.when(
      success: (successState) {
        emit(ApiDataSuccessModel<MODEL>(data: successState, response: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> getIndexData({required ApiInfo info}) async {
    _helper?.initQueries(pApiInfo: info);

    emit(ApiDataLoading<MODEL>());
    final DataState<ApiPaginationModel<MODEL>> dataState = await _helper!.repository!.getPaginateData(info);
    dataState.when(
      success: (successState) {
        if (_helper!.controller != null) {
          _helper!.newSettingForPagination(successState);
        }
      },
      failure: (errorState) {
        controller?.error = errorState;
        _emitError(errorState);
      },
    );
  }

  void _emitError(
    AppError errorState,
  ) {
    emit(ApiDataError<MODEL>(error: errorState));
  }

  @override
  Future<void> close() {
    _helper!.controller?.dispose();
    _helper!.repository = null;
    _helper = null;
    return super.close();
  }
}
