import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/home_tab_body.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/home_tab_tabs.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.primaryLight,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.welcome_back,
              style: TextStyles.regular14White,
            ),
            Text(
              '3laa Omran',
              style: TextStyles.bold24White,
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                themeProvider.switchThemes();
              },
              icon: Icon(
                themeProvider.isDark()
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_outlined,
                color: AppColors.whiteColor,
              )),
          InkWell(
            onTap: () {
              languageProvider.switchLanguages();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Text(
                languageProvider.appLanguage == 'en' ? 'EN' : 'AR',
                style: themeProvider.isDark()
                    ? TextStyles.bold14PrimaryLight.copyWith(
                        color: AppColors.primaryDark,
                      )
                    : TextStyles.bold14PrimaryLight,
              ),
            ),
          ),
          SizedBox(width: width * 0.04),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            decoration: BoxDecoration(
                color: themeProvider.isDark()
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  child: Row(
                    children: [
                      Image.asset(AssetsManager.mapIcon),
                      SizedBox(width: width * 0.02),
                      Text(
                        'Cairo, Egypt',
                        style: TextStyles.medium14White,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                const HomeTabTabs()
              ],
            ),
          ),
          const HomeTabBody(),
        ],
      ),
    );
  }
}
