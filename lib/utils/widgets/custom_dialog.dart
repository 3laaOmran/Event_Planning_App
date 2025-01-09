import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static void showLoading(
      {required BuildContext context,
      required String message,
      Color? bgColor}) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: bgColor,
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryLight,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  message,
                  style: TextStyles.bold16PrimaryLightItalic,
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showAlert({
    required BuildContext context,
    required String message,
    Color? bgColor,
    String title = '',
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: TextStyles.bold14PrimaryLight,
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: TextStyles.bold14PrimaryLight,
          )));
    }
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: bgColor,
            title: Text(
              title,
              style: TextStyles.bold20PrimaryLight,
            ),
            content: Text(
              message,
              style: TextStyles.bold16PrimaryLight,
            ),
            actions: actions,
          );
        });
  }
}
