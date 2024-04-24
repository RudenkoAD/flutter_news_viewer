import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_news_viewer/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_news_viewer/domain/model/filter.dart';
part 'page_state.dart';
part 'page_event.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final NewsRepository newsRepository = GetIt.I.get<NewsRepository>();

  PageBloc() : super(const PageState()) {
    on<PageEvent>((event, emit) async {
      try {
        switch (event.runtimeType) {
          case (const (PageInitialized)):
            logger.i('PageInitialized');
            final newArticles = await _getArticles(event, emit, state);
            emit(state.copyWith(
                articles: newArticles, status: PostStatus.success));
          case (const (PageNumberIncremented)):
            logger.i('PageNumberIncremented, new page: ${state.page + 1}');
            final newState = state.copyWith(page: state.page + 1);
            final newArticles = await _getArticles(event, emit, newState);
            emit(newState.copyWith(
                articles: newArticles, status: PostStatus.success));
            break;
          case (const (PageNumberDecremented)):
            logger.i(
                'PageNumberDecremented, new page: ${max(1, state.page - 1)}');
            final newState = state.copyWith(page: max(1, state.page - 1));
            final newArticles = await _getArticles(event, emit, newState);
            emit(newState.copyWith(
                articles: newArticles, status: PostStatus.success));
            break;
          case (const (PageCountryChanged)):
            logger.d(
                'PageCountryChanged, country: ${(event as PageCountryChanged).country}');
            var newState = state.copyWith(country: event.country);
            logger.d('emitting state $newState');
            emit(newState);
            break;
          case (const (ApiKeyEntered)):
            logger
                .d('ApiKeyEntered, apiKey: ${(event as ApiKeyEntered).apiKey}');
            emit(state.copyWith(apiKey: (event).apiKey));
            break;
          case (const (FilterModified)):
            logger.d(
                'FilterModified, filter: ${(event as FilterModified).filter}');
            final newState = state.copyWith(filter: event.filter);
            final newArticles = await _getArticles(event, emit, newState);
            emit(newState.copyWith(
                articles: newArticles, status: PostStatus.success));
            break;
          case (const (FilterModifiedKeywords)):
            logger.d(
                'FilterModifiedKeywords, keywords: ${(event as FilterModifiedKeywords).keywords}');
            final newfilter = (state.filter ?? Filter.all())
                .setKeywords((event).keywords.toLowerCase().split(' '));
            final newState = state.copyWith(filter: newfilter);
            final newArticles = await _getArticles(event, emit, newState);
            emit(newState.copyWith(
                articles: newArticles, status: PostStatus.success));
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
          apiKey: newstate.apiKey,
          country: newstate.country,
          category: newstate.category,
          q: newstate.q,
          pageSize: newstate.pageSize,
          page: newstate.page);
      logger.i('bloc got ${articles.length} articles from newsapi.org');
      return articles
          .where((element) => state.filter?.test(element) ?? true)
          .toList();
    } catch (e) {
      logger.e('bloc failed to get articles: $e');
      return [];
    }
  }
}
