part of 'page_bloc.dart';

enum PostStatus { initial, success, failure }

final class PageState extends Equatable {
  final String apiKey;
  final PostStatus status;
  final List<Article> articles;

  final String? country;
  static final countries = <String>[
    'ae',
    'ar',
    'at',
    'au',
    'be',
    'bg',
    'br',
    'ca',
    'ch',
    'cn',
    'co',
    'cu',
    'cz',
    'de',
    'eg',
    'fr',
    'gb',
    'gr',
    'hk',
    'hu',
    'id',
    'ie',
    'il',
    'in',
    'it',
    'jp',
    'kr',
    'lt',
    'lv',
    'ma',
    'mx',
    'my',
    'ng',
    'nl',
    'no',
    'nz',
    'ph',
    'pl',
    'pt',
    'ro',
    'rs',
    'ru',
    'sa',
    'se',
    'sg',
    'si',
    'sk',
    'th',
    'tr',
    'tw',
    'ua',
    'us',
    've',
    'za'
  ];
  final String? category;
  final String? q;
  final int pageSize;
  final int page;

  const PageState(
      {this.apiKey = "4fe40c4277a54c70ab601aa41bbad727",
      this.status = PostStatus.initial,
      this.articles = const <Article>[],
      this.country = 'us',
      this.category,
      this.q,
      this.pageSize = 20,
      this.page = 1});

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
