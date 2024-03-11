import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatelessWidget {
  final String url;
  late final WebViewController controller;
  ArticlePage({super.key, required this.url}){
    controller = WebViewController()
  ..setBackgroundColor(Colors.transparent)
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Page'),
      ),
      body: WebViewWidget(controller: controller,
      ),
    );
  }
}