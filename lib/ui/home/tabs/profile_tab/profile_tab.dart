import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/auth/login/login_screen.dart';
import 'package:evently_app/ui/home/tabs/profile_tab/widgets/change_theme_bottom_sheet.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
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
    var eventListProvider = Provider.of<EventListProvider>(context);
    // var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CashHelper.getData(key: 'uName'),
                    style: TextStyles.bold24White,
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    CashHelper.getData(key: 'uEmail'),
                    style: TextStyles.medium16White,
                  )
                ],
              ),
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
            CustomElevatedButton(
              onPressed: () {
                CashHelper.removeData(key: 'uId');
                CashHelper.removeData(key: 'uName');
                CashHelper.removeData(key: 'uEmail');
                eventListProvider.filteredEventsList = [];
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              bgColor: AppColors.redColor,
              border: BorderSide.none,
              buttonText: Row(
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
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
