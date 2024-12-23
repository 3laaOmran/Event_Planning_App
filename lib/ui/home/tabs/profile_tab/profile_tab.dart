import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/profile_tab/widgets/change_theme_bottom_sheet.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'widgets/change_lang_bottom_sheet.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.2,
        backgroundColor: AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: languageProvider.appLanguage == 'en'
                ? const Radius.circular(64)
                : Radius.zero,
            bottomRight: languageProvider.appLanguage == 'ar'
                ? const Radius.circular(64)
                : Radius.zero,
          ),
        ),
        title: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(500),
                  bottomRight: const Radius.circular(500),
                  topRight: languageProvider.appLanguage == 'en'
                      ? const Radius.circular(500)
                      : const Radius.circular(24),
                  topLeft: languageProvider.appLanguage == 'en'
                      ? const Radius.circular(24)
                      : const Radius.circular(500),
                ),
                child: Image.asset(AssetsManager.routeImage)),
            SizedBox(
              width: width * 0.03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '3laa Omran',
                  style: TextStyles.bold24White,
                ),
                Text(
                  '3laaomran1102002@gmail.com',
                  style: TextStyles.medium16White,
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: themeProvider.isDark()
                  ? TextStyles.bold20White
                  : TextStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    // backgroundColor: themeProvider.isDark()?AppColors.primaryDark:AppColors.whiteColor,
                    constraints: BoxConstraints(
                      maxHeight: height * 0.25,
                    ),
                    context: context,
                    builder: (context) => const ChangeLanguageBottomSheet());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryLight,
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: TextStyles.bold20PrimaryLight,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 34,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.018,
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: themeProvider.isDark()
                  ? TextStyles.bold20White
                  : TextStyles.bold20Black,
            ),
            SizedBox(
              height: height * 0.018,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    // backgroundColor: themeProvider.isDark()?AppColors.primaryDark:AppColors.whiteColor,
                    constraints: BoxConstraints(
                      maxHeight: height * 0.25,
                    ),
                    context: context,
                    builder: (context) => const ChangeThemeBottomSheet());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryLight,
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.appTheme == ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: TextStyles.bold20PrimaryLight,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 34,
                      color: AppColors.primaryLight,
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.redColor,
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.logout,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logout,
                      style: TextStyles.regular20White,
                    ),
                  ],
                )),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
