import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/event_details.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    if (eventListProvider.favoriteEvents.isEmpty) {
      eventListProvider.getFavoriteEvents();
    }
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
        Expanded(
          child: eventListProvider.favoriteEvents.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetsManager.onboardingOneDark),
                      Text(
                        AppLocalizations.of(context)!.no_fav_events,
                        style: TextStyles.bold20PrimaryLight,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: eventListProvider.favoriteEvents.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EventDetails.routeName,
                          arguments: eventListProvider.favoriteEvents[index]);
                    },
                    child: EventItem(
                      eventModel: eventListProvider.favoriteEvents[index],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
