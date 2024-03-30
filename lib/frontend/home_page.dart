import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              BlocBuilder<PageBloc, PageState>(builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    if (state.apiKey != null) {
                      context.read<PageBloc>().add(PageInitialized());
                      Navigator.of(context).pushNamed('/news');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('error: API key not set! please contact the developer.'),
                        ),
                      );
                    }
                  },
                  child: Text('Go to News', style: theme.textTheme.titleMedium, textAlign: TextAlign.center,),
                );
              }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dark Mode: '),
                  Switch(
                    value: theme == ThemeCubit.darkTheme,
                    onChanged: (value) {
                      context.read<ThemeCubit>().changeTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const CoutryMenu(),
              const SizedBox(height: 16),
              const ApiKeyTextField(),
            ],
          ),
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
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        final country = state.country;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Country: '),
            DropdownButton<String>(
                value: country,
                onChanged: (String? newValue) {
                  context.read<PageBloc>().add(PageCountryChanged(newValue!));
                },
                items: items),
          ],
        );
      },
    );
  }
}