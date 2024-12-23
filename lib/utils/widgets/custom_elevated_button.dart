import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color bgColor;
  final Widget buttonText;
  final void Function() onPressed;
  final BorderSide? border;

  const CustomElevatedButton(
      {super.key,
      required this.bgColor,
      required this.buttonText,
      required this.onPressed,
      this.border});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              side: border ??
                  const BorderSide(width: 1, color: AppColors.primaryLight),
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: bgColor,
          ),
          onPressed: onPressed,
          child: buttonText),
    );
  }
}
