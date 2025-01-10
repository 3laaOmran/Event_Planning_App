import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/choose_location_widget.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/date_time_widget.dart';
import 'package:evently_app/ui/home/tabs/home_tab/widget/tab_bar_widget.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/widgets/show_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'add_event';

  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedItem = 0;
  DateTime? selectedDate;
  String? selectedTime;
  var eventTitleController = TextEditingController();
  var eventDescriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String selectedImage = '';
  String selectedEventType = '';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> tabSNameList = [
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

    selectedImage = eventListProvider.imagesList[selectedItem];
    selectedEventType = tabSNameList[selectedItem];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: TextStyles.regular22primaryLight,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    eventListProvider.imagesList[selectedItem],
                    height: height * 0.25,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.06,
                  child: ListView.builder(
                      itemCount: tabSNameList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                            padding:
                                EdgeInsetsDirectional.only(end: width * 0.02),
                            child: InkWell(
                              onTap: () {
                                selectedItem = index;
                                setState(() {});
                              },
                              child: TabBarWidget(
                                  inListView: true,
                                  tabName: tabSNameList[index],
                                  isSelected: selectedItem == index,
                                  tabIcon: iconsName[index]),
                            ),
                          )),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: themeProvider.isDark()
                      ? TextStyles.medium16White
                      : TextStyles.medium16black,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .event_title_validation;
                      }
                      return null;
                    },
                    prefixIcon:
                        ImageIcon(AssetImage(AssetsManager.eventTitleIcon)),
                    hintText: AppLocalizations.of(context)!.event_title,
                    controller: eventTitleController),
                SizedBox(
                  height: height * 0.02,
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
                CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .event_description_validation;
                      }
                      return null;
                    },
                    maxLines: 4,
                    hintText: AppLocalizations.of(context)!.event_description,
                    controller: eventDescriptionController),
                SizedBox(
                  height: height * 0.02,
                ),
                DateTimeWidget(
                    lang: languageProvider.appLanguage,
                    isDark: themeProvider.isDark(),
                    onChoosePressed: chooseDate,
                    imageIcon: AssetsManager.eventDateIcon,
                    title: AppLocalizations.of(context)!.event_date,
                    choose: selectedDate == null
                        ? AppLocalizations.of(context)!.choose_date
                        : DateFormat('dd/MM/yyyy').format(selectedDate!)),
                SizedBox(
                  height: height * 0.01,
                ),
                DateTimeWidget(
                  lang: languageProvider.appLanguage,
                  isDark: themeProvider.isDark(),
                  onChoosePressed: chooseTime,
                  imageIcon: AssetsManager.eventTimeIcon,
                  title: AppLocalizations.of(context)!.event_time,
                  choose: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : selectedTime!,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: themeProvider.isDark()
                      ? TextStyles.medium16White
                      : TextStyles.medium16black,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                ChooseLocationWidget(
                  image: AssetsManager.locationIcon,
                  text: Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          AppLocalizations.of(context)!.choose_location,
                          style: TextStyles.medium16primaryLight,
                        )),
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
                  height: height * 0.02,
                ),
                CustomElevatedButton(
                    bgColor: AppColors.primaryLight,
                    buttonText: Text(
                      AppLocalizations.of(context)!.add_event,
                      style: TextStyles.medium20White,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (selectedTime == null || selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.02),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              dismissDirection: DismissDirection.horizontal,
                              backgroundColor: AppColors.redColor,
                              content: Text(
                                textAlign: TextAlign.center,
                                AppLocalizations.of(context)!
                                    .event_date_time_validation,
                                style: TextStyles.medium16White,
                              ),
                            ),
                          );
                        } else {
                          EventModel event = EventModel(
                              // isFavorite: false,
                              image: selectedImage,
                              eventType: selectedEventType,
                              title: eventTitleController.text,
                              description: eventDescriptionController.text,
                              dateTime: selectedDate!,
                              time: selectedTime!);
                          var userProvider = Provider.of<UserProvider>(
                              context, listen: false);
                          FirebaseUtils.addEventToFireStore(event, userProvider
                              .currentUser!.id)
                              .then((value) {
                            eventListProvider
                                .getAllEvents(userProvider.currentUser!.id);
                            ToastMessage.showToast(
                                message:
                                    AppLocalizations.of(context)!.event_added);
                            Navigator.pop(context);
                          });
                        }
                      }
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate(bool isDark, String lang) async {
    var date = await showDatePicker(
      locale: Locale(lang),
      lastDate: DateTime.now().add(Duration(days: 365)),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: isDark
              ? Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    surface: AppColors.primaryDark,
                    primary: AppColors.primaryLight, // header background color
                    onPrimary: AppColors.whiteColor, // header text color
                    onSurface: AppColors.whiteColor, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.whiteColor,
                    ),
                  ),
                )
              : Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryLight, // header background color
                    onPrimary: AppColors.whiteColor, // header text color
                    onSurface: AppColors.primaryDark, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryDark,
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );
    selectedDate = date;
    setState(() {});
  }

  void chooseTime(bool isDark, String lang) async {
    var time = await showTimePicker(
        builder: (context, child) {
          return Theme(
              data: isDark
                  ? Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        surface: AppColors.primaryDark,
                        primary:
                            AppColors.primaryLight, // header background color
                        onPrimary: AppColors.whiteColor, // header text color
                        onSurface: AppColors.whiteColor, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.whiteColor,
                        ),
                      ),
                    )
                  : Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            AppColors.primaryLight, // header background color
                        onPrimary: AppColors.whiteColor, // header text color
                        onSurface: AppColors.primaryDark, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryDark,
                        ),
                      ),
                    ),
              child: child!);
        },
        context: context,
        initialTime: TimeOfDay.now());
    selectedTime = time!.format(context);
    setState(() {});
  }
}
