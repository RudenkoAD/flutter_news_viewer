import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_viewer/logger.dart';

part 'favourite_state.dart';

final class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteState());

  void addFavourite(Article article) {
    final List<Article> newFavouriteArticles = List<Article>.from(state.favouriteArticles);
    newFavouriteArticles.add(article);
    emit(state.copyWith(favouriteArticles: newFavouriteArticles));
  }

  void removeFavourite(Article article) {
    final List<Article> newFavouriteArticles = List<Article>.from(state.favouriteArticles);
    newFavouriteArticles.remove(article);
    emit(state.copyWith(favouriteArticles: newFavouriteArticles));
  }

  List<Article> getFavouriteArticles() {
    return state.favouriteArticles;
  }

  bool isFavourite(Article article) {
    return state.favouriteArticles.contains(article);
  }
  
  void toggleFavourite(Article article) {
    if (isFavourite(article)) {
      removeFavourite(article);
    } else {
      addFavourite(article);
    }
  }

  void clearFavourites() {
    emit(state.copyWith(favouriteArticles: const <Article>[]));
  }

}