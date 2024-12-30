import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ChooseLocationWidget extends StatelessWidget {
  final String image;
  final Widget text;

  const ChooseLocationWidget(
      {super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: AppColors.primaryLight,
          )),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.015),
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8)),
            child: ImageIcon(
              AssetImage(image),
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(
            width: width * .02,
          ),
          text,
        ],
      ),
    );
  }
}
