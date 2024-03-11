import 'package:flutter_news_viewer/data/api/model/api_article.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';

class ArticleMapper {
  static Article fromApi(ApiArticle apiArticle) {
    return Article(
      source: apiArticle.source,
      author: apiArticle.author,
      title: apiArticle.title,
      description: apiArticle.description,
      url: apiArticle.url,
      urlToImage: apiArticle.urlToImage,
      publishedAt: DateTime.parse(apiArticle.publishedAt),
      content: apiArticle.content,
    );
  }
}