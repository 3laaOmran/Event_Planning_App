// import 'package:flutter/material.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   ThemeMode appTheme = ThemeMode.light;
//
//   void changeTheme(ThemeMode newTheme) {
//     if (appTheme == newTheme) {
//       return;
//     }
//     appTheme = newTheme;
//     notifyListeners();
//   }
//
//   void switchThemes() {
//     if (appTheme == ThemeMode.dark) {
//       appTheme = ThemeMode.light;
//     } else {
//       appTheme = ThemeMode.dark;
//     }
//     notifyListeners();
//   }
//
//   bool isDark() => appTheme == ThemeMode.dark;
// }
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  ThemeProvider() {
    loadTheme();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
    CashHelper.saveData(key: 'appTheme', value: newTheme.index);
  }

  void switchThemes() async {
    appTheme = (appTheme == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    CashHelper.saveData(key: 'appTheme', value: appTheme.index);
  }

  bool isDark() => appTheme == ThemeMode.dark;

  Future<void> loadTheme() async {
    final themeIndex =
        CashHelper.getData(key: 'appTheme') ?? ThemeMode.light.index;
    appTheme = ThemeMode.values[themeIndex];
    notifyListeners();
  }
}
