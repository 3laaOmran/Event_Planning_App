import 'package:evently_app/ui/auth/login/login_navigator.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:evently_app/utils/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreenViewModel extends ChangeNotifier {
  // todo: hold data && handle logic

  //TODO: ------------ Data --------------------
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  //TODO: ------------ Logic --------------------
  void login({
    required String loadingMsg,
    required String successTitleMsg,
    required String successMsg,
    required String errorTitleMsg,
    required String errorMsg,
  }) async {
    if (formKey.currentState!.validate()) {
      navigator.showLoading(loadingMsg);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }

        CashHelper.saveData(key: 'uId', value: user.id);
        CashHelper.saveData(key: 'uName', value: user.name);
        CashHelper.saveData(key: 'uEmail', value: user.email);

        navigator.hideLoading();
        navigator.showMessage(successMsg, successTitleMsg, () {
          navigator.gotoHome(HomeScreen.routeName);
        });
      } catch (e) {
        navigator.hideLoading();
        navigator.showMessage(errorMsg, errorTitleMsg);
      }
    }
  }

  Future<UserCredential?> signInWithGoogle({
    required String loadingMsg,
    required String successTitleMsg,
    required String successMsg,
    required String errorTitleMsg,
    required String errorMsg,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      navigator.showLoading(loadingMsg);
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // print('User email ${cred}');
      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      UserModel userModel = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.additionalUserInfo!.profile!['name'],
          email: userCredential.additionalUserInfo!.profile!['email']);
      CashHelper.saveData(key: 'uId', value: userModel.id);
      CashHelper.saveData(key: 'uName', value: userModel.name);
      CashHelper.saveData(key: 'uEmail', value: userModel.email);
      CashHelper.saveData(key: 'loginWithGoogle', value: true);
      await FirebaseUtils.addUserToFireStore(userModel);
      navigator.hideLoading();
      navigator.showMessage(successMsg, successTitleMsg, () {
        navigator.gotoHome(HomeScreen.routeName);
      }); // CustomDialog.showAlert(
      //     context: context,
      //     title: AppLocalizations.of(context)!.success,
      //     posActionName: AppLocalizations.of(context)!.ok,
      //     posAction: (){
      //       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      //     },
      //     message: AppLocalizations.of(context)!.login_successfully);
      return userCredential;
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(errorMsg, errorTitleMsg);
      return null;
    }
  }
}
