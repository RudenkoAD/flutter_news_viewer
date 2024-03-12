import 'package:flutter_news_viewer/data/api/model/api_article.dart';
import 'package:dio/dio.dart';
import 'package:flutter_news_viewer/data/api/request/get_news_body.dart';

import 'package:flutter_news_viewer/logger.dart';

class NewsApiService {
  static const baseUrl = 'https://newsapi.org/v2';
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<ApiArticle>> getNews({required GetnewsBody body}) async {
    try {
      final query = body.toJson();
      logger.d("query: $query\n");
      final response = await dio.get(
        '/top-headlines',
        queryParameters: query,
      );
      logger.i("fetched ${response.data['totalResults']} articles from newsapi.org");
      logger.d("response: $response\n");
      final articles = response.data['articles'] as List;
      return articles.map((json) => ApiArticle.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
