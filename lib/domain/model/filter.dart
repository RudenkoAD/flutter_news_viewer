import 'package:flutter_news_viewer/domain/model/article.dart';

class Filter{
  final List<String> _keywords = [];
  String _author = '';
  DateTime _from = DateTime(2000);
  DateTime _to = DateTime.now();

  Filter._();

  Filter setKeywords(List<String> keywords){
    _keywords.clear();
    _keywords.addAll(keywords);
    return this;
  }

  bool test(Article article) {
    for (var keyword in _keywords) {
      if (!article.title.toLowerCase().contains(keyword)) {
        return false;
      }
    }
    if (!(((article.author??'').toLowerCase()).contains(_author))) {
      return false;
    }
    if(!article.publishedAt.isAfter(_from) || !article.publishedAt.isBefore(_to)){
      return false;
    }
    return true;
  }

  factory Filter.contains(String keyword){
    var filter = Filter._();
    filter._keywords.add(keyword.toLowerCase());
    return filter;
  }

  Filter contains(String keyword) {
    _keywords.add(keyword.toLowerCase());
    return this;
  }

  factory Filter.fromAuthor(String keyword){
    var filter = Filter._();
    filter._author = keyword.toLowerCase();
    return filter;
  }

  Filter fromAuthor(String keyword) {
    _author = keyword.toLowerCase();
    return this;
  }

  factory Filter.fromDate(DateTime date){
    var filter = Filter._();
    filter._from = date;
    return filter;
  }

  Filter fromDate(DateTime date) {
    _from = date;
    return this;
  }

  factory Filter.toDate(DateTime date){
    var filter = Filter._();
    filter._to = date;
    return filter;
  }

  Filter toDate(DateTime date) {
    _to = date;
    return this;
  }

  factory Filter.all(){
    return Filter._();
  }

  Filter reset(){
    _keywords.clear();
    _author = '';
    _from = DateTime(2000);
    _to = DateTime.now();
    return this;
  }

}