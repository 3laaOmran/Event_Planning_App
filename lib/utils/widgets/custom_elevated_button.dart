import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color bgColor;
  final Widget buttonText;
  final void Function() onPressed;

  const CustomElevatedButton(
      {super.key,
      required this.bgColor,
      required this.buttonText,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: bgColor,
        ),
        onPressed: onPressed,
        child: buttonText);
  }
}
