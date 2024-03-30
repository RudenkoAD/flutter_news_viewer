import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_viewer/logger.dart';

part 'favourite_state.dart';

final class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(const FavouriteState());

  void addFavourite(Article article) {
    logger.i('added to favourites: ${article.title}');
    final List<Article> newFavouriteArticles = List<Article>.from(state.articles);
    newFavouriteArticles.add(article);
    emit(state.copyWith(articles: newFavouriteArticles));
  }

  void removeFavourite(Article article) {
    logger.i('removed from favourites: ${article.title}');
    final List<Article> newFavouriteArticles = List<Article>.from(state.articles);
    newFavouriteArticles.remove(article);
    emit(state.copyWith(articles: newFavouriteArticles));
  }

  bool _isFavourite(Article article) {
    return state.articles.contains(article);
  }
  
  void toggleFavourite(Article article) {
    if (_isFavourite(article)) {
      removeFavourite(article);
    } else {
      addFavourite(article);
    }
  }

  void clearFavourites() {
    emit(state.copyWith(articles: const <Article>[]));
  }

}