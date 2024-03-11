import 'package:flutter_news_viewer/domain/repository/news_repository.dart';
import 'api_module.dart';

class RepositoryModule {
  static NewsRepository? _newsRepository;

  static NewsRepository newsRepository() {
    _newsRepository ??= NewsRepository(ApiModule.apiEndpoint());
    return _newsRepository!;
  }
}
