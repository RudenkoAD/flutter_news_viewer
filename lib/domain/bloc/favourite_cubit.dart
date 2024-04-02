// ignore_for_file: prefer_single_quotes

import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_viewer/logger.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'favourite_state.dart';

final class FavouriteCubit extends HydratedCubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteState());

  void addFavourite(Article article) {
    logger.i('added to favourites: ${article.title}');
    final List<Article> newFavouriteArticles =
        List<Article>.from(state.articles);
    newFavouriteArticles.add(article);
    emit(state.copyWith(articles: newFavouriteArticles));
  }

  void removeFavourite(Article article) {
    logger.i('removed from favourites: ${article.title}');
    final List<Article> newFavouriteArticles =
        List<Article>.from(state.articles);
    newFavouriteArticles.remove(article);
    emit(state.copyWith(articles: newFavouriteArticles));
  }

  void toggleFavourite(Article article) {
    if (state.isFavourite(article)) {
      removeFavourite(article);
    } else {
      addFavourite(article);
    }
  }

  void clearFavourites() {
    emit(state.copyWith(articles: const <Article>[]));
  }

  @override
  FavouriteState? fromJson(Map<String, dynamic> json) {
    final List<Article> articles = (json['state'] as List)
        .map((e) => Article.fromJson(e as Map<String, dynamic>))
        .toList();
    return FavouriteState(articles: articles);
  }

  @override
  Map<String, dynamic>? toJson(FavouriteState state) =>
      {"state": state.articles.map((e) => e.toJson()).toList()};
}
