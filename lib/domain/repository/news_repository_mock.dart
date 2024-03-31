import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository.dart';

class NewsRepositoryMock implements NewsRepository {
  @override
  Future<List<Article>> getNews(
      {String? apiKey,
      String? country,
      String? category,
      String? sources,
      String? q,
      required int pageSize,
      required int page}) {
    return Future.value([
      Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle",
          description: "TestDescription",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less."),
      Article(
          source: const {"source": "Test"},
          author: null,
          title: "NullTestTitle",
          description: null,
          url: "https://abc.com/",
          urlToImage: null,
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: null)
    ]);
  }
}
