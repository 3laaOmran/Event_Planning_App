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
}
