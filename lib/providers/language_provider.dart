import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = CashHelper.getData(key: 'appLanguage') ?? 'en';

  void changeLanguage({required String newLanguage}) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    CashHelper.saveData(key: 'appLanguage', value: newLanguage);
    notifyListeners();
  }

  void switchLanguages() {
    if (appLanguage == 'en') {
      appLanguage = 'ar';
      CashHelper.saveData(key: 'appLanguage', value: 'ar');
    } else {
      appLanguage = 'en';
      CashHelper.saveData(key: 'appLanguage', value: 'en');
    }
    notifyListeners();
  }
}
