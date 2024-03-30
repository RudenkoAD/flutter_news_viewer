import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/article_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: const Stack(
        children: [
          Center(child: ArticleList()),
          Center(child: Overlay()),
        ],
      ),
    );
  }
}

class ArticleList extends ConsumerWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, watch, _) {
        final state = ref.watch(pageProvider);
        if (state.status == PostStatus.initial) {
          return const CircularProgressIndicator();
        } else if (state.status == PostStatus.success) {
          if (state.articles.isEmpty) {
            return const Center(child: Text('No articles found'));
          }
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return ArticleTile(article: article);
            },
          );
        } else {
          return const Text('Something went wrong!');
        }
      },
    );
  }
}

class ArticleTile extends ConsumerWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = ref.watch(themeProvider).textTheme;
    return Material(
      child: GestureDetector(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: SizedBox(
              width: 100,
              height: 100,
              child: article.urlToImage == null
                  ? const ImageIcon(AssetImage('assets/placeholder.png'))
                  : Image.network(article.urlToImage!),
            ),
            title: Text(
              article.title,
              style: textTheme.bodyLarge,
            ),
            subtitle: Text(article.description ?? 'no description available',
              style: textTheme.bodySmall),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/article',
            arguments: ArticlePageArguments(article: article));
        },
      ),
    );
  }
}

class Overlay extends ConsumerWidget {
  //implement buttons to switch pages
  const Overlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageBloc pageBloc = ref.watch(pageProvider.bloc);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                pageBloc.add(PageNumberDecremented());
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                pageBloc.add(PageNumberIncremented());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
