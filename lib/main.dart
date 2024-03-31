import 'package:flutter/material.dart';
import 'internal/application.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_news_viewer/internal/getit.dart';

Future main() async {
  setupRelease();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
