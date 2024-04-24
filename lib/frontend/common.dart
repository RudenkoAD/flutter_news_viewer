import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
import 'package:flutter_news_viewer/domain/model/article.dart';
import 'package:flutter_news_viewer/frontend/article_page_arguments.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleTile extends StatefulWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  ArticleTileState createState() => ArticleTileState();
}

class ArticleTileState extends State<ArticleTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Article article;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    article = widget.article;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_controller);
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 50), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 30), weight: 50),
    ]).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
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
                          ? const ImageIcon(
                              AssetImage('assets/placeholder.png'))
                          : Image.network(article.urlToImage!)),
                ),
                title: Text(
                  article.title,
                  style: textTheme.bodyLarge,
                ),
                subtitle: Text(
                    article.description ?? 'no description available',
                    style: textTheme.bodySmall),
                trailing: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return IconButton(
                        icon: ScaleTransition(
                          scale: _sizeAnimation,
                          child: Icon(Icons.favorite,
                              color: _colorAnimation.value, size: 1),
                        ),
                        onPressed: () {
                          ref.read(favouriteProvider).isFavourite(article)
                              ? _controller.reverse()
                              : _controller.forward();
                          ref
                              .read(favouriteProvider.bloc)
                              .toggleFavourite(article);
                        },
                      );
                    }),
              )),
          onTap: () {
            Navigator.pushNamed(context, '/article',
                arguments: ArticlePageArguments(article: article));
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
