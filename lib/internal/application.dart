import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/frontend/article_page.dart';
import 'package:flutter_news_viewer/frontend/home_page.dart';
import 'package:flutter_news_viewer/frontend/news_page.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageBloc()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const AppWindow(),
    );
  }
}

class AppWindow extends StatelessWidget {
  const AppWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
      return MaterialApp(
          title: 'Flutter News Viewer',
          theme: theme,
          home: const HomePage(),
          routes: {
            '/news': (context) => const NewsPage(),
            '/article': (context) => const ArticlePage(),
            '/home': (context) => const HomePage(),
          });
    });
  }
}
