import 'package:flutter/material.dart';
import 'internal/application.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future main() async {
  runApp(
    const ProviderScope(
      child: App(),
    ),
    );
}

