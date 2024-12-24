import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarWidget extends StatelessWidget {
  final String tabName;
  final IconData tabIcon;
  final bool isSelected;

  const TabBarWidget(
      {super.key,
      required this.tabName,
      required this.isSelected,
      required this.tabIcon});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.013, horizontal: width * 0.035),
      decoration: BoxDecoration(
          color: themeProvider.isDark()
              ? isSelected
                  ? AppColors.primaryLight
                  : AppColors.transparent
              : isSelected
                  ? AppColors.whiteColor
                  : AppColors.transparent,
          borderRadius: BorderRadius.circular(46),
          border: Border.all(
            width: 1,
            color: themeProvider.isDark()
                ? AppColors.primaryLight
                : AppColors.whiteColor,
          )),
      child: Row(
        children: [
          Icon(
            tabIcon,
            color: themeProvider.isDark()
                ? AppColors.whiteColor
                : isSelected
                    ? AppColors.primaryLight
                    : AppColors.whiteColor,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            tabName,
            style: themeProvider.isDark()
                ? TextStyles.medium16White
                : isSelected
                    ? TextStyles.medium16primaryLight
                    : TextStyles.medium16White,
          ),
        ],
      ),
    );
  }
}
