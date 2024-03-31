import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_news_viewer/domain/bloc/favourite_cubit.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/internal/getit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('FavouriteCubit', () {
    late Storage storage;
    late FavouriteCubit favouriteCubit;

    setUpAll(() => setupMock());

    setUp(() {
      storage = MockStorage();
      when(
        () => storage.write(any(), any<dynamic>()),
      ).thenAnswer((_) async {});
      HydratedBloc.storage = storage;
      favouriteCubit = FavouriteCubit();
    });

    tearDown(() {
      favouriteCubit.close();
    });

    test('addFavourite should add article to favourites', () {
      final article = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle",
          description: "TestDescription",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      favouriteCubit.addFavourite(article);
      expect(favouriteCubit.state.articles, contains(article));
    });

    test('removeFavourite should remove article from favourites', () {
      final article = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle",
          description: "TestDescription",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      favouriteCubit.addFavourite(article);
      favouriteCubit.removeFavourite(article);
      expect(favouriteCubit.state.articles, isNot(contains(article)));
    });

    test('toggleFavourite should add article to favourites if not already favourited', () {
      final article = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle",
          description: "TestDescription",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      favouriteCubit.toggleFavourite(article);
      expect(favouriteCubit.state.articles, contains(article));
    });

    test('toggleFavourite should remove article from favourites if already favourited', () {
      final article = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle",
          description: "TestDescription",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      favouriteCubit.addFavourite(article);
      favouriteCubit.toggleFavourite(article);
      expect(favouriteCubit.state.articles, isNot(contains(article)));
    });

    test('clearFavourites should remove all articles from favourites', () {
      final article1 = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle1",
          description: "TestDescription1",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      final article2 = Article(
          source: const {"source": "Test"},
          author: "Author McAuthorson",
          title: "TestTitle2",
          description: "TestDescription2",
          url: "https://abc.com/",
          urlToImage:
              "https://almadeladanza.ru/wp-content/uploads/b/b/c/bbc2ecc9cde1018cf1c4beaefa945f21.png",
          publishedAt: DateTime(2024, 3, 31, 0, 0),
          content: "This is a test article. Nothing more, nothing less.");
      favouriteCubit.addFavourite(article1);
      favouriteCubit.addFavourite(article2);
      favouriteCubit.clearFavourites();
      expect(favouriteCubit.state.articles, isEmpty);
    });
  });
}