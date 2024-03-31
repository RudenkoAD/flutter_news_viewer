import 'package:flutter_news_viewer/data/api/api_endpoint.dart';
import 'package:flutter_news_viewer/data/api/service/newsapi_service.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

void setup() {
  getIt.registerSingleton<NewsApiService>(NewsApiService());
  getIt.registerSingleton<ApiEndpoint>(ApiEndpoint());
  getIt.registerSingleton<NewsRepository>(NewsRepositoryImp());
}
