import 'package:evently_app/ui/home/tabs/home_tab/widget/home_tab_body.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: height * 0.09,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: CustomTextFormField(
              prefixIcon: Image.asset(AssetsManager.searchIcon),
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintStyle: TextStyles.bold14PrimaryLight,
              borderColor: AppColors.primaryLight,
              controller: searchController),
        ),
        const HomeTabBody(),
      ],
    );
  }
}
