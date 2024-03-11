import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/frontend/news_page.dart';

class App extends MaterialApp{
  const App({super.key}) : super(home: const NewsPage());
}