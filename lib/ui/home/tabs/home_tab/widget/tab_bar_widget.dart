import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarWidget extends StatelessWidget {
  final String tabName;
  final IconData tabIcon;
  final bool isSelected;
  final bool? inListView;

  const TabBarWidget({
    super.key,
    required this.tabName,
    required this.isSelected,
    required this.tabIcon,
    this.inListView,
  });

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
                  ? inListView == null
                      ? AppColors.primaryLight
                      : AppColors.primaryLight
                  : AppColors.transparent
              : isSelected
                  ? inListView == null
                      ? AppColors.whiteColor
                      : AppColors.primaryLight
                  : AppColors.transparent,
          borderRadius: BorderRadius.circular(46),
          border: Border.all(
              width: 1,
              color: themeProvider.isDark()
                  ? inListView == null
                      ? AppColors.primaryLight
                      : AppColors.primaryLight
                  : inListView == null
                      ? AppColors.whiteColor
                      : AppColors.primaryLight)),
      child: Row(
        children: [
          Icon(
            tabIcon,
            color: themeProvider.isDark()
                ? inListView == null
                    ? AppColors.whiteColor
                    : isSelected
                        ? AppColors.whiteColor
                        : AppColors.primaryLight
                : isSelected
                    ? inListView == null
                        ? AppColors.primaryLight
                        : AppColors.whiteColor
                    : inListView == null
                        ? AppColors.whiteColor
                        : AppColors.primaryLight,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            tabName,
            style: themeProvider.isDark()
                ? inListView == null
                    ? TextStyles.medium16White
                    : isSelected
                        ? TextStyles.medium16White
                        : TextStyles.medium16primaryLight
                : isSelected
                    ? inListView == null
                        ? TextStyles.medium16primaryLight
                        : TextStyles.medium16White
                    : inListView == null
                        ? TextStyles.medium16White
                        : TextStyles.medium20primaryLight,
          ),
        ],
      ),
    );
  }
}
