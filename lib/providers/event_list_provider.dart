import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];
  List<EventModel> filteredEventsList = [];
  int selectedIndex = 0;

  List<String> tabSNameList = [];

  void getTabsNameList(BuildContext context) {
    tabSNameList = [
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
  }

  void getAllEvents() async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .get();
    eventsList = querySnapshot.docs.map((event) {
      return event.data();
    }).toList();
    filteredEventsList = eventsList;
    notifyListeners();
  }

  void getFilteredEvents() async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .get();
    eventsList = querySnapshot.docs.map((event) {
      return event.data();
    }).toList();

    filteredEventsList = eventsList.where((event) {
      return event.eventType == tabSNameList[selectedIndex];
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      getAllEvents();
    } else {
      getFilteredEvents();
    }
  }

  Future<void> updateFavorite(String docId, bool isFavorite) async {
    var collection = await FirebaseUtils.getEventCollection();
    await collection.doc(docId).update({'isFavorite': isFavorite}).timeout(
        Duration(milliseconds: 500), onTimeout: () {
      selectedIndex == 0 ? getAllEvents() : getFilteredEvents();
      getFavoriteEvents();
    });
  }

  void toggleFavorite(String docId, bool isFavorite) {
    updateFavorite(docId, !isFavorite);
  }

  List<EventModel> favoriteEvents = [];

  void getFavoriteEvents() async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .get();
    eventsList = querySnapshot.docs.map((event) {
      return event.data();
    }).toList();

    favoriteEvents = eventsList.where((event) {
      return event.isFavorite == true;
    }).toList();
    // print('fav7');
    notifyListeners();
  }
}
