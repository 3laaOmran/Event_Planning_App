import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme =
      ThemeMode.values[CashHelper.getData(key: 'appTheme') ?? 0];

  void changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
    CashHelper.saveData(key: 'appTheme', value: newTheme.index);
  }

  void switchThemes() async {
    appTheme = appTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    CashHelper.saveData(key: 'appTheme', value: appTheme.index);
  }

  bool isDark() => appTheme == ThemeMode.dark;
}
