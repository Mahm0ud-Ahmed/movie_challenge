// Package imports:
import 'package:dio/dio.dart';
import 'package:movie_challange/src/core/utils/constant.dart';

class DataInterceptor extends Interceptor {
  DataInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'api_key': kApiKey,
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

}
