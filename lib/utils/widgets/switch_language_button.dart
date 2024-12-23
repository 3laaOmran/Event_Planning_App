import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
    return GestureDetector(
      onTap: () {
        languageProvider.switchLanguages();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            languageProvider.appLanguage == 'en'
                ? getSelectedIcon(Image.asset(AssetsManager.englishFlag))
                : getUnselectedIcon(Image.asset(AssetsManager.englishFlag)),
            SizedBox(
              width: width * .03,
            ),
            languageProvider.appLanguage == 'en'
                ? getUnselectedIcon(Image.asset(AssetsManager.arabicFlag))
                : getSelectedIcon(Image.asset(AssetsManager.arabicFlag)),
          ],
        ),
      ),
    );
  }

  Widget getSelectedIcon(Widget child) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(50)),
      child: child,
    );
  }

  Widget getUnselectedIcon(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: child,
    );
  }
}
