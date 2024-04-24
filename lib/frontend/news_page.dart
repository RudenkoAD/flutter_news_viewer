import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/frontend/common.dart';
import 'package:flutter_news_viewer/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        flexibleSpace: Placeholder(),
        expandedHeight: 20,
        title: FilterUI(),
      ),
      SliverStack(children: const <Widget>[
        ArticleList(),
        SliverPositioned.fill(child: Overlay()),
      ]),
    ]));
  }
}

class ArticleList extends ConsumerWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pageProvider);
    logger.d('rebuilding ArticleList with new state');
    if (state.status == PostStatus.initial) {
      return const SliverToBoxAdapter(child: CircularProgressIndicator());
    } else if (state.status == PostStatus.success) {
      if (state.articles.isEmpty) {
        return const SliverToBoxAdapter(
            child: Center(child: Text('No articles found')));
      }
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final article = state.articles[index];
            return ArticleTile(article: article);
          },
          childCount: state.articles.length,
        ),
      );
    } else {
      return const Text('Something went wrong!');
    }
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
                pageBloc.add(const PageNumberDecremented());
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                pageBloc.add(const PageNumberIncremented());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}

class FilterUI extends ConsumerWidget {
  const FilterUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageBloc pageBloc = ref.watch(pageProvider.bloc);

    //display only the keywords and a button to dispay more options in a row
    //if the button is pressed, display the author and date options
    //also make all the options editable
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter search keywords',
            ),
            onSubmitted: (text) =>
                {pageBloc..add(FilterModifiedKeywords(text))},
          ),
        ),
      ],
    );
  }
}
