import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:flutter/cupertino.dart';

class EventListProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];
  List<EventModel> filteredEventsList = [];
  int selectedIndex = 0;

  // List<String> tabSNameList = [];
  //
  // void getTabsNameList(BuildContext context) {
  //   tabSNameList = [
  //     AppLocalizations.of(context)!.all,
  //     AppLocalizations.of(context)!.sport,
  //     AppLocalizations.of(context)!.birthday,
  //     AppLocalizations.of(context)!.book,
  //     AppLocalizations.of(context)!.meeting,
  //     AppLocalizations.of(context)!.eating,
  //     AppLocalizations.of(context)!.exhibition,
  //     AppLocalizations.of(context)!.gaming,
  //     AppLocalizations.of(context)!.work_shop,
  //     AppLocalizations.of(context)!.holiday,
  //   ];
  // }
  List<String> imagesList = [
    AssetsManager.sportImage,
    AssetsManager.birthdayImage,
    AssetsManager.bookClubImage,
    AssetsManager.meetingImage,
    AssetsManager.eatingImage,
    AssetsManager.exhibitionImage,
    AssetsManager.gamingImage,
    AssetsManager.workShopImage,
    AssetsManager.holidayImage,
  ];
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
      return event.image == imagesList[selectedIndex - 1];
    }).toList();
    // sort events
    // filteredEventsList.sort((event1,event2){
    //   return event1.dateTime.compareTo(event2.dateTime);
    // });
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
    notifyListeners();
  }

  Future<void> deleteEvent(String docId) async {
    var collection = await FirebaseUtils.getEventCollection();
    await collection.doc(docId).delete().timeout(Duration(milliseconds: 500),
        onTimeout: () {
      selectedIndex == 0 ? getAllEvents() : getFilteredEvents();
      getFavoriteEvents();
    });
  }

  Future<void> updateEvent({
    required String docId,
    required String image,
    required String eventType,
    required String title,
    required String description,
    required DateTime dateTime,
    required String time,
  }) async {
    var collection = await FirebaseUtils.getEventCollection();
    await collection.doc(docId).update({
      'image': image,
      'eventType': eventType,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
    }).then((value) {
      print('updated Successfully');
      selectedIndex == 0 ? getAllEvents() : getFilteredEvents();
      getFavoriteEvents();
    });
  }
}
