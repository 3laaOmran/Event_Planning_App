import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  void switchThemes() {
    if (appTheme == ThemeMode.dark) {
      appTheme = ThemeMode.light;
    } else {
      appTheme = ThemeMode.dark;
    }
    notifyListeners();
  }

  bool isDark() => appTheme == ThemeMode.dark;
}
