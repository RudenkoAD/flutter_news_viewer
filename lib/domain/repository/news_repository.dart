import 'package:flutter_news_viewer/data/api/api_endpoint.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';

class NewsRepository {
  final ApiEndpoint _apiEndpoint;

  NewsRepository(this._apiEndpoint);

  Future<List<Article>> getNews(
      {String? apiKey,
      String? country,
      String? category,
      String? sources,
      String? q,
      required int pageSize,
      required int page}) {
    if (apiKey == null) {
      throw ArgumentError.notNull('apiKey');
    }
    return _apiEndpoint.getNews(
        apiKey: apiKey,
        country: country,
        category: category,
        sources: sources,
        q: q,
        pageSize: pageSize,
        page: page);
  }
}
