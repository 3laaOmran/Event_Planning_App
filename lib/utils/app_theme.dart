import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.whiteColor,
      ),
      primaryColor: AppColors.primaryLight,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
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

  ///**********************************************************

  static final ThemeData darkTheme = ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.primaryDark,
      ),
      scaffoldBackgroundColor: AppColors.primaryDark,
      primaryColor: AppColors.primaryDark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
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
        selectedLabelStyle: TextStyles.bold12White,
        unselectedLabelStyle: TextStyles.bold12White,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ));
}
