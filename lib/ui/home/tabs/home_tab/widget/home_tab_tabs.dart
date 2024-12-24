import 'package:evently_app/ui/home/tabs/home_tab/widget/tab_bar_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTabTabs extends StatefulWidget {
  const HomeTabTabs({super.key});

  @override
  State<HomeTabTabs> createState() => _HomeTabTabsState();
}

class _HomeTabTabsState extends State<HomeTabTabs> {
  @override
  Widget build(BuildContext context) {
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
    var width = MediaQuery.of(context).size.width;
    int selectedIndex = 0;
    return DefaultTabController(
      length: tabSNameList.length,
      child: TabBar(
        padding: EdgeInsetsDirectional.only(start: width * 0.03),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        dividerColor: AppColors.transparent,
        labelPadding: EdgeInsets.symmetric(horizontal: width * 0.015),
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        indicatorColor: AppColors.transparent,
        tabs: tabSNameList.map((tabName) {
          return TabBarWidget(
            tabIcon: iconsName[tabSNameList.indexOf(tabName)],
            tabName: tabName,
            isSelected: selectedIndex == tabSNameList.indexOf(tabName),
          );
        }).toList(),
      ),
    );
  }
}
