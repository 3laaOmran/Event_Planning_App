import 'package:evently_app/ui/auth/register/register_navigator.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:evently_app/utils/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  //todo: Hold data & Handle logic

  //TODO: ------------ Data --------------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late RegisterNavigator registerNavigator;

  //TODO: ------------ Logic --------------------
  void register({
    required String loadingMsg,
    required String successTitleMsg,
    required String successMsg,
    required String errorTitleMsg,
    required String errorMsg,
  }) async {
    if (formKey.currentState!.validate()) {
      registerNavigator.showLoading(loadingMsg);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        UserModel user = UserModel(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFireStore(user);
        CashHelper.saveData(key: 'uId', value: user.id);
        CashHelper.saveData(key: 'uName', value: user.name);
        CashHelper.saveData(key: 'uEmail', value: user.email);
        registerNavigator.hideLoading();
        registerNavigator.showMessage(successMsg, successTitleMsg, () {
          registerNavigator.gotoHome(HomeScreen.routeName);
        });
      } catch (e) {
        registerNavigator.hideLoading();
        registerNavigator.showMessage(
            errorTitleMsg, errorMsg); // CustomDialog.showAlert(
      }
    }
  }
}
