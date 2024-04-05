import '../models/api_pagination_model.dart';
import 'model_type.dart';

ApiPaginationModel<T> parseApiPagination<T>(ApiPaginationModel args) {
  final result = args.results.map<T>((json) => parseModel<T>(json)).toList();
  return args.copyWithChangeType<T>(data: result);
}

T parseModel<T>(dynamic json) => ModelType.getParseData<T>(json);
