import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/event_details.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  var searchController = TextEditingController();
  List<EventModel> filteredList = [];
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    if (eventListProvider.favoriteEvents.isEmpty) {
      eventListProvider.getFavoriteEvents();
    }
    filteredList = eventListProvider.favoriteEvents.where((event) {
      return event.title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Column(
      children: [
        SizedBox(
          height: height * 0.09,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: CustomTextFormField(
              onChanged: (value) {
                searchText = value;
                setState(() {});
              },
              prefixIcon: Image.asset(AssetsManager.searchIcon),
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintStyle: TextStyles.bold14PrimaryLight,
              borderColor: AppColors.primaryLight,
              controller: searchController),
        ),
        Expanded(
          child: filteredList.isEmpty
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
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EventDetails.routeName,
                          arguments: filteredList[index]);
                    },
                    child: EventItem(
                      eventModel: filteredList[index],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
