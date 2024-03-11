part of 'page_bloc.dart';

enum PostStatus { initial, success, failure }

final class PageState extends Equatable {
  final PostStatus status;
  final List<Article> articles;

  final String? country;
  final String? category;
  final String? q;
  final int pageSize;
  final int page;

  const PageState(
      {this.status = PostStatus.initial,
      this.articles = const <Article>[],
      this.country = 'ru',
      this.category,
      this.q,
      this.pageSize = 20,
      this.page = 1});

  PageState copyWith({
    PostStatus? status,
    List<Article>? articles,
    String? country,
    String? category,
    String? q,
    int? pageSize,
    int? page,
  }) {
    return PageState(
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
      [status, articles, country, category, q, pageSize, page];
}
