import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
import 'package:flutter_news_viewer/frontend/common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavouritePage extends ConsumerWidget {
  const FavouritePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favourite Articles'),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final state = ref.watch(favouriteProvider);
          if (state.articles.isEmpty) {
            return const Center(
                child: Text(
                    'No articles favourited yet! Head to the news page and favourite some!'));
          }
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return ArticleTile(article: article);
            },
          );
        },
      ),
    );
  }
}
