import 'package:qualita/data/models/base_model.dart';

class QueryResponse {
  bool hasError;
  String? message;
  QueryResponse({this.hasError = false, this.message});
}

class MultipleDataResponse<T extends BaseModel> extends QueryResponse {
  List<T> data;
  MultipleDataResponse({super.hasError, super.message, this.data = const []});
}

class SingleDataResponse<T extends BaseModel> extends QueryResponse {
  T? data;
  SingleDataResponse({super.hasError, super.message, this.data});
}
