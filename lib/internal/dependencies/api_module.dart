import 'package:flutter_news_viewer/data/api/api_endpoint.dart';
import 'package:flutter_news_viewer/data/api/service/newsapi_service.dart';

class ApiModule{
  static ApiEndpoint? _apiEndpoint;

  static ApiEndpoint apiEndpoint(){
    _apiEndpoint ??= ApiEndpoint(NewsApiService());
    return _apiEndpoint!;
  }
}