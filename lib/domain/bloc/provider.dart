import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/favourite_cubit.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';

import 'package:riverbloc/riverbloc.dart';

final pageProvider = BlocProvider<PageBloc, PageState>(
  (ref) => PageBloc(),
);

final favouriteProvider = BlocProvider<FavouriteCubit, FavouriteState>(
  (ref) => FavouriteCubit(),
);

final themeProvider = BlocProvider<ThemeCubit, ThemeData>(
  (ref) => ThemeCubit(),
);