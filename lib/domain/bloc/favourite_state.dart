part of 'favourite_cubit.dart';

enum PostStatus { initial, success, failure }

final class FavouriteState extends Equatable {
  final List<Article> favouriteArticles;

  const FavouriteState({this.favouriteArticles = const <Article>[]});


  FavouriteState copyWith({List<Article>? favouriteArticles}) {
    return FavouriteState(favouriteArticles: favouriteArticles ?? this.favouriteArticles);
  }

  @override
  List<Object?> get props => [favouriteArticles];
}
