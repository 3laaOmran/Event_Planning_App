import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChangeThemeBottomSheet extends StatefulWidget {
  const ChangeThemeBottomSheet({super.key});

  @override
  State<ChangeThemeBottomSheet> createState() => _ChangeThemeBottomSheetState();
}

class _ChangeThemeBottomSheetState extends State<ChangeThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: themeProvider.appTheme == ThemeMode.light
                ? getSelectedItem(AppLocalizations.of(context)!.light)
                : getUnselectedItem(AppLocalizations.of(context)!.light),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: themeProvider.appTheme == ThemeMode.dark
                ? getSelectedItem(AppLocalizations.of(context)!.dark)
                : getUnselectedItem(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyles.bold20PrimaryLight,
        ),
        const Icon(
          Icons.check,
          size: 35,
          color: AppColors.primaryLight,
        ),
      ],
    );
  }

  Widget getUnselectedItem(String text) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        Text(
          text,
          style: themeProvider.isDark()
              ? TextStyles.bold20White
              : TextStyles.bold20Black,
        ),
      ],
    );
  }
}
