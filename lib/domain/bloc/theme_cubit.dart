import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/logger.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeCubit.lightTheme);

  static final darkTheme = ThemeData.dark();
  static final lightTheme = ThemeData.light();

  void changeTheme() {
    logger.i('changeTheme');
    emit(state == darkTheme ? lightTheme : darkTheme);
  }
}
