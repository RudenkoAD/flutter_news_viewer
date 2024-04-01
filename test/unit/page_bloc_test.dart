import 'package:flutter_news_viewer/domain/repository/news_repository_mock.dart';
import 'package:test/test.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/internal/getit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('PageBloc', () {
    late PageBloc pageBloc;

    setUpAll(() => setupMock());

    setUp(() {
      pageBloc = PageBloc();
    });

    tearDown(() {
      pageBloc.close();
    });

    test('initial state is correct', () {
      expect(pageBloc.state, const PageState());
    });

    blocTest(
      'PageInitialized event updates state correctly',
      build: () => pageBloc,
      act: (bloc) => bloc.add(const PageInitialized()),
      expect: () =>
          [PageState(articles: mockArticles(), status: PostStatus.success)],
    );

    blocTest(
      'PageNumberIncremented event updates state correctly',
      build: () => pageBloc,
      act: (bloc) => bloc.add(const PageNumberIncremented()),
      expect: () => [
        PageState(articles: mockArticles(), page: 2, status: PostStatus.success)
      ],
    );

    blocTest(
      'PageNumberDecremented event updates state correctly',
      build: () => pageBloc,
      act: (bloc) {
        bloc.add(const PageNumberIncremented());
        bloc.add(const PageNumberIncremented());
        bloc.add(const PageNumberDecremented());
      },
      expect: () => [
        PageState(
            articles: mockArticles(), page: 2, status: PostStatus.success),
        PageState(
            articles: mockArticles(), page: 3, status: PostStatus.success),
        PageState(articles: mockArticles(), page: 2, status: PostStatus.success)
      ],
    );
    blocTest(
      'PageCountryChanged event updates state correctly',
      build: () => pageBloc,
      act: (bloc) => bloc.add(const PageCountryChanged('us')),
      expect: () => [const PageState(country: 'us')],
    );
  });
}
