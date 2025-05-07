import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) {
    return ThemeNotifier();
  },
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void changeDarkMode() {
    state = state.copyWith(!state.isDarkMode);
  }
}
