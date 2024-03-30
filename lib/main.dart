import 'package:flutter/material.dart';
import 'internal/application.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart' as provider;

final pageProvider = provider.pageProvider;
final favouriteProvider = provider.favouriteProvider;
final themeProvider = provider.themeProvider;

Future main() async {
  runApp(
    const ProviderScope(
      child: App(),
    ),
    );
}

