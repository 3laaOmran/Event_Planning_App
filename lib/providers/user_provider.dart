import 'package:evently_app/utils/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  void updateUser(UserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
