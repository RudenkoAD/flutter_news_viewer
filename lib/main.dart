import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'internal/application.dart';
import 'package:riverbloc/riverbloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



Future main() async {
  runApp(
    const ProviderScope(
      child: App(),
    ),
    );
}
