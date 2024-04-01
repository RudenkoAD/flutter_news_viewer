import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_news_viewer/domain/bloc/theme_cubit.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state should be light theme', () {
      expect(themeCubit.state, equals(ThemeCubit.lightTheme));
    });

    test('changeTheme should toggle between light and dark themes', () {
      final initialTheme = themeCubit.state;

      themeCubit.changeTheme();
      expect(themeCubit.state, equals(ThemeCubit.darkTheme));

      themeCubit.changeTheme();
      expect(themeCubit.state, equals(ThemeCubit.lightTheme));

      expect(themeCubit.state, equals(initialTheme));
    });
  });
}
