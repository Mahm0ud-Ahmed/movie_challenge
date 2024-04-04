// ignore_for_file: public_member_api_docs, sort_constructors_first

// Project imports:
import 'constant.dart';

class ApiInfo {
  String? baseUrl;
  String endpoint;
  Map<String, dynamic>? queries;
  int? page;
  int? pageSize;

  ApiInfo({
    this.baseUrl = kBaseUrl,
    required this.endpoint,
    this.queries,
    this.page = 1,
    this.pageSize = 20,
  });

  ApiInfo copyWith({
    String? baseUrl,
    String? endpoint,
    Map<String, dynamic>? queries,
    int? page,
    int? pageSize,
  }) {
    return ApiInfo(
      baseUrl: baseUrl ?? this.baseUrl,
      endpoint: endpoint ?? this.endpoint,
      queries: queries ?? this.queries,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  String toString() {
    return 'ApiInfo(baseUrl: $baseUrl, endpoint: $endpoint, queries: $queries, page: $page, pageSize: $pageSize)';
  }
}
