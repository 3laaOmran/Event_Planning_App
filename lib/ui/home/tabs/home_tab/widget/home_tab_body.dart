import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/assets_manager.dart';

class HomeTabBody extends StatelessWidget {
  const HomeTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.01,
          ),
          itemCount: 5,
          itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.01,
                ),
                height: height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.primaryLight),
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AssetsManager.birthdayImage)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: themeProvider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.025, vertical: height * 0.002),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            '21',
                            style: TextStyles.bold20PrimaryLight,
                          ),
                          Text(
                            'Nov',
                            style: TextStyles.bold14PrimaryLight,
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: themeProvider.isDark()
                            ? AppColors.primaryDark
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'This Is My Birthday Barty',
                            style: themeProvider.isDark()
                                ? TextStyles.bold14white
                                : TextStyles.bold14black,
                          )),
                          const Icon(
                            CupertinoIcons.heart,
                            color: AppColors.primaryLight,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
