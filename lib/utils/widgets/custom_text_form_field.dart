import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isObscure;
  final TextEditingController controller;
  final Color? borderColor;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      this.hintStyle,
      this.suffixIcon,
      this.prefixIcon,
      this.isObscure,
        required this.controller, this.borderColor});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      obscureText: isObscure ?? false,
      controller: controller,
      style: themeProvider.isDark()
          ? TextStyles.medium16White
          : TextStyles.medium16grey,
      cursorColor: AppColors.primaryLight,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor:
            themeProvider.isDark() ? AppColors.whiteColor : AppColors.greyColor,
        suffixIconColor:
            themeProvider.isDark() ? AppColors.whiteColor : AppColors.greyColor,
        hintText: hintText,
        hintStyle: themeProvider.isDark()
            ? hintStyle ?? TextStyles.medium16White
            : hintStyle ?? TextStyles.medium16grey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: borderColor == null ? themeProvider.isDark()
                ? AppColors.whiteColor
                : AppColors.greyColor : borderColor!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 1,
            color: themeProvider.isDark()
                ? AppColors.whiteColor
                : AppColors.greyColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.redColor,
          ),
        ),
      ),
    );
  }
}
