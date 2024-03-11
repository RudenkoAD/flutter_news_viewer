class ApiArticle{
  final Map<String, dynamic> source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  ApiArticle.fromJson(Map<String, dynamic> json)
      : source = json['source'],
        author = json['author']??'',
        title = json['title']??'',
        description = json['description']??'',
        url = json['url']??'',
        urlToImage = json['urlToImage']??'',
        publishedAt = json['publishedAt'],
        content = json['content']??'';
}