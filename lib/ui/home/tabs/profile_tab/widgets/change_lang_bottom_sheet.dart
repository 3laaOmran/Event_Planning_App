import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage(newLanguage: 'en');
              Navigator.pop(context);
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedItem(AppLocalizations.of(context)!.english)
                : getUnselectedItem(AppLocalizations.of(context)!.english),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage(newLanguage: 'ar');
              Navigator.pop(context);
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedItem(AppLocalizations.of(context)!.arabic)
                : getUnselectedItem(AppLocalizations.of(context)!.arabic),
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
