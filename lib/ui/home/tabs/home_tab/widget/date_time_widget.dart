import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef onchoose = Function(bool isDark, String lang);

class DateTimeWidget extends StatelessWidget {
  final String imageIcon;
  final String title;
  final String choose;
  final bool isDark;
  final String lang;
  final onchoose onChoosePressed;

  const DateTimeWidget(
      {super.key,
      required this.imageIcon,
      required this.title,
      required this.choose,
      required this.onChoosePressed,
      required this.isDark,
      required this.lang});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        ImageIcon(
          AssetImage(imageIcon),
          color: themeProvider.isDark()
              ? AppColors.whiteColor
              : AppColors.blackColor,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Expanded(
            child: Text(
          title,
          style: themeProvider.isDark()
              ? TextStyles.medium16White
              : TextStyles.medium16black,
        )),
        InkWell(
          onTap: () {
            onChoosePressed(isDark, lang);
          },
          child: Text(
            choose,
            style: TextStyles.medium16primaryLight,
          ),
        ),
      ],
    );
  }
}
