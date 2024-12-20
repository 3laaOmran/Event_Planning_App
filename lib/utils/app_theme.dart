import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.whiteColor, width: 5),
        ),
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyles.bold12White,
        unselectedLabelStyle: TextStyles.bold12White,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ));
  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.whiteColor, width: 4),
        ),
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ));
}
