import 'package:json_annotation/json_annotation.dart';
part 'api_article.g.dart';

@JsonSerializable()
class ApiArticle{
  final Map<String, dynamic> source;
  final String author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  ApiArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });

  factory ApiArticle.fromJson(Map<String, dynamic> json) => _$ApiArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ApiArticleToJson(this);
}