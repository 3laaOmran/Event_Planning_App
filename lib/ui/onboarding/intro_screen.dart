import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/onboarding/onboarding_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/switch_app_theme_button.dart';
import 'package:evently_app/utils/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'intro_screen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        title: Image.asset(AssetsManager.eventlyHorizontalLogo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(themeProvider.isDark()
                ? AssetsManager.introScreenDark
                : AssetsManager.introScreenLight),
            Text(
              AppLocalizations.of(context)!.introScreenTitle,
              style: TextStyles.bold20PrimaryLight,
            ),
            Text(
              AppLocalizations.of(context)!.introScreenContent,
              style: themeProvider.isDark()
                  ? TextStyles.medium16White
                  : TextStyles.medium16black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: TextStyles.medium20primaryLight,
                ),
                const SwitchLanguageButton()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: TextStyles.medium20primaryLight,
                ),
                const SwitchAppThemeButton()
              ],
            ),
            CustomElevatedButton(
                bgColor: AppColors.primaryLight,
                buttonText: Text(
                  AppLocalizations.of(context)!.letsStart,
                  style: TextStyles.medium20White,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, OnboardingScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
