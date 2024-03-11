import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (context, theme) {
      return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          title: Text('Flutter News App', style: theme.textTheme.titleMedium),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/news');
                },
                child: Text('Go to News', style: theme.textTheme.titleMedium),
              ),
              const SizedBox(height: 16),
              Switch(
                value: theme == ThemeCubit.lightTheme,
                onChanged: (value) {
                  context.read<ThemeCubit>().changeTheme();
                },
              ),
              const SizedBox(height: 16),
              const CoutryMenu()
            ],
          ),
        ),
      );
    });
  }
}

class CoutryMenu extends StatelessWidget {
  const CoutryMenu({super.key});

  static final items = <String>[
    'ae',
    'ar',
    'at',
    'au',
    'be',
    'bg',
    'br',
    'ca',
    'ch',
    'cn',
    'co',
    'cu',
    'cz',
    'de',
    'eg',
    'fr',
    'gb',
    'gr',
    'hk',
    'hu',
    'id',
    'ie',
    'il',
    'in',
    'it',
    'jp',
    'kr',
    'lt',
    'lv',
    'ma',
    'mx',
    'my',
    'ng',
    'nl',
    'no',
    'nz',
    'ph',
    'pl',
    'pt',
    'ro',
    'rs',
    'ru',
    'sa',
    'se',
    'sg',
    'si',
    'sk',
    'th',
    'tr',
    'tw',
    'ua',
    'us',
    've',
    'za'
  ]
      .map<DropdownMenuItem<String>>((String value) =>
          DropdownMenuItem<String>(value: value, child: Text(value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        final country = state.country;
        return DropdownButton<String>(
            value: country,
            onChanged: (String? newValue) {
              context.read<PageBloc>().add(PageCountryChanged(newValue!));
            },
            items: items);
      },
    );
  }
}
