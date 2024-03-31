part of 'favourite_cubit.dart';

enum PostStatus { initial, success, failure }

final class FavouriteState extends Equatable {
  final List<Article> articles;

  const FavouriteState({this.articles = const <Article>[]});


  FavouriteState copyWith({List<Article>? articles}) {
    return FavouriteState(articles: articles ?? this.articles);
  }

  bool isFavourite(Article article) {
    return articles.contains(article);
  }

  @override
  List<Object?> get props => [articles];
}
