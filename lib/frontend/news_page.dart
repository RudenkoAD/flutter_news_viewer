import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/article_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Headlines'),
        ),
        body: BlocProvider(
            create: (_) => PageBloc()..add(PageNumberIncremented()),
            child: const Stack(children: [
              Center(child: ArticleList()),
              Center(child: Overlay()),
            ])));
  }
}

class ArticleList extends StatelessWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        if (state.status == PostStatus.initial) {
          return const CircularProgressIndicator();
        } else if (state.status == PostStatus.success) {
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

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: GestureDetector(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            leading: article.urlToImage != ""
                ? Image.network(article.urlToImage)
                : const Icon(Icons.face),
            title: Text(
              article.title,
              style: textTheme.bodyLarge,
            ),
            subtitle: Text(article.description, style: textTheme.bodySmall),
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

class Overlay extends StatelessWidget {
  //implement buttons to switch pages
  const Overlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<PageBloc>().add(PageNumberDecremented());
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PageBloc>().add(PageNumberIncremented());
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
