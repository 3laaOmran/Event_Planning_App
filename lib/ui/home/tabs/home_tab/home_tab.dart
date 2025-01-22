import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/event_details.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/tab_bar_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    // eventListProvider.getTabsNameList(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    // var userProvider = Provider.of<UserProvider>(context);
    if (eventListProvider.eventsList.isEmpty) {
      // eventListProvider.getAllEvents(userProvider.currentUser!.id);
      eventListProvider.getAllEvents(CashHelper.getData(key: 'uId'));
    }

    List<String> tabSNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.book,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.work_shop,
      AppLocalizations.of(context)!.holiday,
    ];

    List<IconData> iconsName = [
      CupertinoIcons.compass,
      Icons.directions_bike_outlined,
      Icons.cake_outlined,
      CupertinoIcons.book,
      Icons.meeting_room_outlined,
      Icons.set_meal_outlined,
      Icons.shop_two_outlined,
      CupertinoIcons.game_controller,
      Icons.work_outline_sharp,
      Icons.holiday_village_outlined,
    ];
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
              CashHelper.getData(key: 'uName'),
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
                DefaultTabController(
                  length: tabSNameList.length,
                  child: TabBar(
                    padding: EdgeInsetsDirectional.only(start: width * 0.03),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: AppColors.transparent,
                    labelPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.015),
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(
                          index, CashHelper.getData(key: 'uId'));
                    },
                    indicatorColor: AppColors.transparent,
                    tabs: tabSNameList.map((tabName) {
                      return TabBarWidget(
                        tabIcon: iconsName[tabSNameList.indexOf(tabName)],
                        tabName: tabName,
                        isSelected: eventListProvider.selectedIndex ==
                            tabSNameList.indexOf(tabName),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: eventListProvider.filteredEventsList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.onboardingTwoDark,
                          height: height * 0.3,
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          AppLocalizations.of(context)!.no_events,
                          style: TextStyles.bold20PrimaryLight,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                    ),
                    itemCount: eventListProvider.filteredEventsList.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, EventDetails.routeName,
                                arguments: eventListProvider
                                    .filteredEventsList[index]);
                          },
                          child: EventItem(
                            eventModel:
                                eventListProvider.filteredEventsList[index],
                          ),
                        )),
          ),
        ],
      ),
    );
  }
}
