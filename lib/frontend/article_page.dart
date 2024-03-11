import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
class ArticlePageArguments{
  final Article article;
  ArticlePageArguments({required this.article});
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});
  @override
  Widget build(BuildContext context) {
    final ArticlePageArguments arguments = ModalRoute.of(context)!.settings.arguments as ArticlePageArguments;
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
            Image.network(article.urlToImage),
            const SizedBox(height: 16),
            Text(article.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text(article.description, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}