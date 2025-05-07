import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = false,
  });
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xff2862f5),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }

  copyWith(bool? isDarkMode) {
    return AppTheme(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
