import 'package:evently_app/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently_app/ui/home/tabs/home_tab/add_event.dart';
import 'package:evently_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_app/ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently_app/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const MapTab(),
    const FavoriteTab(),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEvent.routeName);
        },
        child: const Icon(
          Icons.add,
          size: 45,
          color: AppColors.whiteColor,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            backgroundColor: AppColors.transparent,
            items: [
              buildBottomNavItem(
                  index: 0,
                  imageNameSelected: AssetsManager.homeIconSelected,
                  imageName: AssetsManager.homeIcon,
                  label: AppLocalizations.of(context)!.home),
              buildBottomNavItem(
                  index: 1,
                  imageNameSelected: AssetsManager.mapIconSelected,
                  imageName: AssetsManager.mapIcon,
                  label: AppLocalizations.of(context)!.map),
              buildBottomNavItem(
                  index: 2,
                  imageNameSelected: AssetsManager.favoriteIconSelected,
                  imageName: AssetsManager.favoriteIcon,
                  label: AppLocalizations.of(context)!.favorite),
              buildBottomNavItem(
                  index: 3,
                  imageNameSelected: AssetsManager.profileIconSelected,
                  imageName: AssetsManager.profileIcon,
                  label: AppLocalizations.of(context)!.profile),
            ]),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavItem(
      {required String imageName,
      required String label,
      required int index,
      required String imageNameSelected}) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
          AssetImage(currentIndex == index ? imageNameSelected : imageName)),
      label: label,
    );
  }
}
