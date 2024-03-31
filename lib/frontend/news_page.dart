import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/frontend/common.dart';
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
