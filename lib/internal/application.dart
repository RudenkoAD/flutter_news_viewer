import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/frontend/article_page.dart';
import 'package:flutter_news_viewer/frontend/home_page.dart';
import 'package:flutter_news_viewer/frontend/news_page.dart';
import 'package:flutter_news_viewer/frontend/favourite_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      return MaterialApp(
          title: 'Flutter News Viewer',
          theme: ref.watch(themeProvider),
          home: const HomePage(),
          routes: {
            '/news': (context) => const NewsPage(),
            '/article': (context) => const ArticlePage(),
            '/home': (context) => const HomePage(),
            '/favourite': (context) => const FavouritePage(),
          });
    }
  }
