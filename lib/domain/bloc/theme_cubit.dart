import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_news_viewer/logger.dart';
class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeCubit.darkTheme);

  static final darkTheme = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 5, 43)),
    textTheme: GoogleFonts.rajdhaniTextTheme(),
  );
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 230, 204, 133)),
    textTheme: GoogleFonts.rajdhaniTextTheme(),
  );

  void changeTheme() {
    logger.i('changeTheme');
    emit(state == darkTheme ? lightTheme : darkTheme);
  }
}
