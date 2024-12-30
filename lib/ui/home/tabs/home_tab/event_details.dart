import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/choose_location_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatelessWidget {
  static const String routeName = 'event_details';

  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: TextStyles.regular22primaryLight,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        actions: [
          Image.asset(AssetsManager.editImage),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Image.asset(AssetsManager.deleteImage),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(args.image)),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                args.title,
                style: TextStyles.medium24PrimaryLight,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ChooseLocationWidget(
                image: AssetsManager.eventDateIcon,
                text: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMMM yyyy').format(args.dateTime),
                      style: TextStyles.medium16primaryLight,
                    ),
                    Text(
                      '${args.time}',
                      style: themeProvider.isDark()
                          ? TextStyles.medium16White
                          : TextStyles.medium16black,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ChooseLocationWidget(
                image: AssetsManager.locationIcon,
                text: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Cairo, Egypt',
                          style: TextStyles.medium16primaryLight,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryLight,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Image.asset(AssetsManager.mapImage),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: themeProvider.isDark()
                    ? TextStyles.medium16White
                    : TextStyles.medium16black,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                args.description,
                style: themeProvider.isDark()
                    ? TextStyles.medium16White
                    : TextStyles.medium16black,
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
