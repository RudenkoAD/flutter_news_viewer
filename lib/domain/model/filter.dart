import 'package:flutter_news_viewer/domain/model/article.dart';

class Filter{
  final List<String> _keywords = [];
  String _author = '';
  Filter._();

  bool test(Article article) {
    for (var keyword in _keywords) {
      if (!article.title.contains(keyword)) {
        return false;
      }
    }
    if (!((article.author??'').contains(_author))) {
      return false;
    }
    return true;
  }

  factory Filter.contains(String keyword){
    var filter = Filter._();
    filter._keywords.add(keyword);
    return filter;
  }

  Filter contains(String keyword) {
    _keywords.add(keyword);
    return this;
  }

  factory Filter.fromAuthor(String keyword){
    var filter = Filter._();
    filter._author = keyword;
    return filter;
  }

  Filter fromAuthor(String keyword) {
    _author = keyword;
    return this;
  }
}