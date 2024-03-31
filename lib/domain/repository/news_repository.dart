import 'package:flutter_news_viewer/domain/model/article.dart';

abstract class NewsRepository{
  Future<List<Article>> getNews(
      {String? apiKey,
      String? country,
      String? category,
      String? sources,
      String? q,
      required int pageSize,
      required int page}
      );
}