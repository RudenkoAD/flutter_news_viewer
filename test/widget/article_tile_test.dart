import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_news_viewer/internal/getit.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  testWidgets('ArticleTile should display article title and description',
      (WidgetTester tester) async {
    // Register our mock storage
    final storage = MockStorage();
    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenReturn(null);
    HydratedBloc.storage = storage;
    // Setup our GetIt instance
    setupMock();

    // Build our widget and trigger a frame.
    await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
      home: ArticleTile(
          article: Article(
              source: const {'source': 'Test'},
              title: 'Article Title',
              description: 'Article Description',
              url: 'https://abc.com/',
              publishedAt: DateTime(2024, 3, 31, 0, 0))),
    )));
    // Verify that our widget has the correct title and description.
    expect(find.text('Article Title'), findsOneWidget);
    expect(find.text('Article Description'), findsOneWidget);
  });
}
