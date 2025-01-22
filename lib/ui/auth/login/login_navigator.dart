abstract class LoginNavigator {
  void showLoading(String message);

  void hideLoading();

  void showMessage(String message, String title, [Function? posAction]);

  void gotoHome(String routeName);
}
