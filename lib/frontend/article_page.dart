import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/article_page_arguments.dart';


class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ArticlePageArguments arguments =
        ModalRoute.of(context)!.settings.arguments as ArticlePageArguments;
    final Article article = arguments.article;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? Image.network(article.urlToImage!)
                : const ImageIcon(AssetImage('assets/placeholder.png')),
            const SizedBox(height: 16),
            Text(article.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(article.description ?? 'No description available',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
