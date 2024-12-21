import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/onboarding/onboarding_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'intro_screen';

  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
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
                GestureDetector(
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
                      children: [
                        languageProvider.appLanguage == 'en'
                            ? getSelectedIcon(
                                Image.asset(AssetsManager.englishFlag))
                            : getUnselectedIcon(
                                Image.asset(AssetsManager.englishFlag)),
                        SizedBox(
                          width: width * .03,
                        ),
                        languageProvider.appLanguage == 'en'
                            ? getUnselectedIcon(
                                Image.asset(AssetsManager.arabicFlag))
                            : getSelectedIcon(
                                Image.asset(AssetsManager.arabicFlag)),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: TextStyles.medium20primaryLight,
                ),
                InkWell(
                  onTap: () {
                    themeProvider.switchThemes();
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
                      children: [
                        themeProvider.isDark()
                            ? getUnselectedIcon(
                                const Icon(
                                  Icons.light_mode_outlined,
                                  color: AppColors.primaryLight,
                                ),
                              )
                            : getSelectedIcon(
                                const Icon(
                                  Icons.light_mode_outlined,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                        SizedBox(
                          width: width * .03,
                        ),
                        themeProvider.isDark()
                            ? getSelectedIcon(const Icon(
                                Icons.dark_mode_rounded,
                                color: AppColors.whiteColor,
                              ))
                            : getUnselectedIcon(
                                const Icon(
                                  Icons.dark_mode_rounded,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
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
