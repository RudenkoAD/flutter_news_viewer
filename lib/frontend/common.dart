import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/article_page_arguments.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                child: Hero(
                    tag: 'article_image_${article.title}',
                    child: article.urlToImage == null
                        ? const ImageIcon(AssetImage('assets/placeholder.png'))
                        : Image.network(article.urlToImage!)),
              ),
              title: Text(
                article.title,
                style: textTheme.bodyLarge,
              ),
              subtitle: Text(article.description ?? 'no description available',
                  style: textTheme.bodySmall),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: ref.watch(favouriteProvider).isFavourite(article)
                      ? Colors.red
                      : null,
                  size: 30,
                ),
                onPressed: () {
                  ref.read(favouriteProvider.bloc).toggleFavourite(article);
                },
              ),
            )),
        onTap: () {
          Navigator.pushNamed(context, '/article',
              arguments: ArticlePageArguments(article: article));
        },
      ),
    );
  }
}
