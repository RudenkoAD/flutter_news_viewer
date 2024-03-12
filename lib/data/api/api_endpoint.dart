import 'package:flutter_news_viewer/data/mapper/article_mapper.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/data/api/request/get_news_body.dart';
import 'package:flutter_news_viewer/data/api/service/newsapi_service.dart';

class ApiEndpoint {
  final NewsApiService _newsApiService;

  ApiEndpoint(this._newsApiService);

  Future<List<Article>> getNews({
    required String apiKey,
    String? country,
    String? category,
    String? sources,
    String? q,
    required int pageSize,
    required int page,
  }) async {
    final body = GetnewsBody(
      apiKey: apiKey,
      country: country,
      category: category,
      sources: sources,
      q: q,
      pageSize: pageSize,
      page: page,
    );

    final apiArticles = await _newsApiService.getNews(body: body);
    return apiArticles
        .map((apiarticle) => ArticleMapper.fromApi(apiarticle))
        .toList();
  }
}
