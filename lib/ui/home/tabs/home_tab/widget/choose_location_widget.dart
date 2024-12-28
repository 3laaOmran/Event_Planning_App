import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseLocationWidget extends StatelessWidget {
  const ChooseLocationWidget({super.key});

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
            child: Image.asset(AssetsManager.locationIcon),
          ),
          SizedBox(
            width: width * .02,
          ),
          Expanded(
              child: Text(
            AppLocalizations.of(context)!.choose_location,
            style: TextStyles.medium16primaryLight,
          )),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primaryLight,
            size: 20,
          ),
        ],
      ),
    );
  }
}
