import 'package:flutter/material.dart';
import 'package:flutter_news_viewer/domain/bloc/provider.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';
import 'package:flutter_news_viewer/domain/bloc/page_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const HomePageView();
  }
}

class HomePageView extends ConsumerWidget {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text('Flutter News App', style: theme.textTheme.titleMedium),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NewsPageButton(),
            const SizedBox(height: 16),
            const FavouritePageButton(),
            const SizedBox(height: 16),
            const ThemeSwitch(),
            const SizedBox(height: 16),
            CoutryMenu(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class NewsPageButton extends ConsumerWidget {
  const NewsPageButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageBloc = ref.watch(pageProvider.bloc);
    final theme = ref.watch(themeProvider);
    return ElevatedButton(
      onPressed: () {
        pageBloc.add(const PageInitialized());
        Navigator.of(context).pushNamed('/news');
      },
      child: Text(
        'Go to News',
        style: theme.textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FavouritePageButton extends ConsumerWidget {
  const FavouritePageButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/favourite');
      },
      child: Text(
        'Go to Favourite',
        style: theme.textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CoutryMenu extends ConsumerWidget {
  CoutryMenu({super.key});
  final List<DropdownMenuItem<String>> items = PageState.countries
      .map((country) => DropdownMenuItem<String>(
            value: country,
            child: Text(country),
          ))
      .toList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Country: '),
        DropdownButton<String>(
            value: ref.watch(pageProvider).country,
            onChanged: (String? newValue) {
              ref.read(pageProvider.bloc).add(PageCountryChanged(newValue!));
            },
            items: items),
      ],
    );
  }
}

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeCubit = ref.watch(themeProvider.bloc);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Dark Mode: '),
        Switch(
          value: theme == ThemeCubit.darkTheme,
          onChanged: (value) {
            themeCubit.changeTheme();
          },
        ),
      ],
    );
  }
}
