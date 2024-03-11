import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
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
              ],
            ),
          ),
        );
      }
    );
  }
}