import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository.dart';
import 'package:flutter_news_viewer/internal/dependencies/repository_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_viewer/logger.dart';

part 'page_state.dart';
part 'page_event.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final NewsRepository newsRepository = RepositoryModule.newsRepository();

  PageBloc() : super(const PageState()) {
    on<PageEvent>((event, emit) async {
      try {
        switch(event.runtimeType){
        case (const (PageNumberIncremented)):
          logger.i('PageNumberIncremented, new page: ${state.page + 1}');
          final newState = state.copyWith(page: state.page + 1);
          final newArticles = await _getArticles(event, emit, newState);
          emit(newState.copyWith(
              articles: newArticles,
              status: PostStatus.success));
          break;
        case (const (PageNumberDecremented)):
          logger.i('PageNumberDecremented, new page: ${max(1, state.page - 1)}');
          final newState = state.copyWith(page: max(1, state.page - 1));
          final newArticles = await _getArticles(event, emit, newState);
          emit(newState.copyWith(
              articles: newArticles,
              status: PostStatus.success));
          break;
        case (const (PageCountryChanged)):
          logger.d('PageCountryChanged, country: ${(event as PageCountryChanged).country}');
          final newstate = state.copyWith(
              country: event.country);
          final newArticles = await _getArticles(event, emit, newstate);
          emit(newstate.copyWith(
              articles: newArticles,
              status: PostStatus.success));
          break;
        }
      } catch (_) {
        emit(state.copyWith(status: PostStatus.failure));
      }
    });
  }

  Future<List<Article>> _getArticles(
      PageEvent event, Emitter<PageState> emit, newstate) async {
    try {
      final articles = await newsRepository.getNews(
          country: newstate.country,
          category: newstate.category,
          q: newstate.q,
          pageSize: newstate.pageSize,
          page: newstate.page);
      logger.i('bloc got ${articles.length} articles from newsapi.org');
      return articles;
    } catch (e) {
      logger.e('bloc failed to get articles: $e');
      return [];
    }
  }
}
