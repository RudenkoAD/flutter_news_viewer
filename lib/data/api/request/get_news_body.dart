import 'package:flutter_news_viewer/data/api/request/base_body.dart';

class GetnewsBody extends BaseBody{
  final String? country;
  final String? category;
  final String? sources;
  final String? q;
  final int pageSize;
  final int page;

  GetnewsBody({
    this.country,
    this.category,
    this.sources,
    this.q,
    required this.pageSize,
    required this.page,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      if (country != null) 'country': country,
      if (category != null) 'category': category,
      if (sources != null) 'sources': sources,
      if (q != null) 'q': q,
      'pageSize': pageSize,
      'page': page,
    };
  }

  @override
  String toString(){
    return 'GetnewsBody{country: $country, category: $category, sources: $sources, q: $q, pageSize: $pageSize, page: $page}';
  }
}