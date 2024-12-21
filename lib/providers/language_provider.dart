import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String appLanguage = 'en';

  void changeLanguage({required String newLanguage}) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void switchLanguages() {
    if (appLanguage == 'en') {
      appLanguage = 'ar';
    } else {
      appLanguage = 'en';
    }
    notifyListeners();
  }
}
