import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchAppThemeButton extends StatelessWidget {
  const SwitchAppThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
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
