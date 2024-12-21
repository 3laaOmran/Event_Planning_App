import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final String heroTag;

  const CustomFloatingActionButton(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: heroTag,
        backgroundColor: AppColors.transparent,
        shape: const StadiumBorder(
            side: BorderSide(
          color: AppColors.primaryLight,
          width: 2,
        )),
        elevation: 0,
        onPressed: onPressed,
        child: Icon(
          icon,
          color: AppColors.primaryLight,
          size: 28,
        ));
  }
}
