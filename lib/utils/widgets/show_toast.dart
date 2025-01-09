import 'package:evently_app/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static Future<bool?> showToast({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.greenColor,
        textColor: AppColors.whiteColor,
        fontSize: 20.0);
  }
}
