import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final EventModel eventModel;

  const EventItem({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.01,
      ),
      height: height * 0.3,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.primaryLight),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage(eventModel.image)),
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
                  '${eventModel.dateTime.day}',
                  style: TextStyles.bold20PrimaryLight,
                ),
                Text(
                  DateFormat('MMM').format(eventModel.dateTime),
                  style: TextStyles.bold16PrimaryLight,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  eventModel.title,
                  style: themeProvider.isDark()
                      ? TextStyles.bold14white
                      : TextStyles.bold14black,
                )),
                InkWell(
                  onTap: () {
                    eventListProvider.toggleFavorite(
                        eventModel.id, eventModel.isFavorite);
                  },
                  child: Icon(
                    eventModel.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
