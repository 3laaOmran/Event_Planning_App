import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = 'onboarding_screen';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<OnboardingModel> pages = [
      OnboardingModel(
          imageLight: AssetsManager.onboardingOneLight,
          imageDark: AssetsManager.onboardingOneDark,
          title: AppLocalizations.of(context)!.onboardingOneTitle,
          content: AppLocalizations.of(context)!.onboardingOneContent),
      OnboardingModel(
          imageLight: AssetsManager.onboardingTwoLight,
          imageDark: AssetsManager.onboardingTwoDark,
          title: AppLocalizations.of(context)!.onboardingTwoTitle,
          content: AppLocalizations.of(context)!.onboardingTwoContent),
      OnboardingModel(
          imageLight: AssetsManager.onboardingThreeLight,
          imageDark: AssetsManager.onboardingThreeDark,
          title: AppLocalizations.of(context)!.onboardingThreeTitle,
          content: AppLocalizations.of(context)!.onboardingThreeContent),
    ];
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        title: Image.asset(AssetsManager.eventlyHorizontalLogo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                controller: pageController,
                onPageChanged: (index) {
                  currentPageIndex = index;
                  setState(() {});
                },
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: height * 0.4),
                      child: Image.asset(themeProvider.isDark()
                          ? pages[index].imageDark
                          : pages[index].imageLight),
                    ),
                    Text(
                      pages[index].title,
                      style: TextStyles.bold20PrimaryLight,
                    ),
                    Text(
                      pages[index].content,
                      style: themeProvider.isDark()
                          ? TextStyles.medium16White
                          : TextStyles.medium16black,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPageIndex != 0
                    ? CustomFloatingActionButton(
                        heroTag: 'prev',
                        icon: Icons.arrow_back,
                        onPressed: () {
                          pageController.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        })
                    : Container(),
                Row(
                  children: List.generate(
                      pages.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: 8,
                              width: currentPageIndex == index ? 21 : 8,
                              decoration: BoxDecoration(
                                color: currentPageIndex == index
                                    ? AppColors.primaryLight
                                    : themeProvider.isDark()
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )),
                ),
                CustomFloatingActionButton(
                    heroTag: 'next',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      currentPageIndex == pages.length - 1
                          ? Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName)
                          : pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OnboardingModel {
  String imageLight;
  String imageDark;
  String title;
  String content;

  OnboardingModel(
      {required this.imageLight,
      required this.imageDark,
      required this.title,
      required this.content});
}
