part of 'page_bloc.dart';

enum PostStatus { initial, success, failure }

final class PageState extends Equatable {
  final String? apiKey;
  final PostStatus status;
  final List<Article> articles;

  final String? country;
  final String? category;
  final String? q;
  final int pageSize;
  final int page;

  const PageState(
      {this.apiKey,
      this.status = PostStatus.initial,
      this.articles = const <Article>[],
      this.country = 'ru',
      this.category,
      this.q,
      this.pageSize = 20,
      this.page = 0});

  PageState copyWith({
    String? apiKey,
    PostStatus? status,
    List<Article>? articles,
    String? country,
    String? category,
    String? q,
    int? pageSize,
    int? page,
  }) {
    return PageState(
        apiKey: apiKey ?? this.apiKey,
        status: status ?? this.status,
        articles: articles ?? this.articles,
        country: country ?? this.country,
        category: category ?? this.category,
        q: q ?? this.q,
        pageSize: pageSize ?? this.pageSize,
        page: page ?? this.page);
  }

  @override
  List<Object?> get props =>
      [apiKey, status, articles, country, category, q, pageSize, page];
}
