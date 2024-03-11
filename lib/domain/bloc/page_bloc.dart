import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/domain/repository/news_repository.dart';
import 'package:flutter_news_viewer/internal/dependencies/repository_module.dart';
import 'package:equatable/equatable.dart';
part 'page_state.dart';
part 'page_event.dart';


class PageBloc extends Bloc<PageEvent, PageState> {
  final NewsRepository newsRepository = RepositoryModule.newsRepository();

  PageBloc() : super(const PageState()){
    on<PageEvent>((event, emit) async {
      try{
        if (event is PageNumberIncremented) {
          emit(state.copyWith(page: state.page + 1, articles: await _getArticles(event, emit, state.page+1), status: PostStatus.success));
        } else if (event is PageNumberDecremented) {
          emit(state.copyWith(page: state.page - 1, articles: await _getArticles(event, emit, state.page-1), status: PostStatus.success));
        }
      } catch (_) {
        emit(state.copyWith(status: PostStatus.failure));
      }
    });
  }
  
  Future<List<Article>> _getArticles(PageEvent event, Emitter<PageState> emit, page) async {
    try {
      final articles = await newsRepository.getNews(country: state.country, category: state.category, q: state.q, pageSize: state.pageSize, page: page);
      return articles;
    } catch (_) {
      return [];
    }
  }
}