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

  void getAllEvents(String uId) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
            .orderBy('dateTime', descending: false)
            .get();
    eventsList = querySnapshot.docs.map((event) {
      return event.data();
    }).toList();
    filteredEventsList = eventsList;
    notifyListeners();
  }

  void getFilteredEvents(String uId) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
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

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilteredEvents(uId);
    }
  }

  Future<void> updateFavorite(String docId, bool isFavorite, String uId) async {
    var collection = await FirebaseUtils.getEventCollection(uId);
    await collection
        .doc(docId)
        .update({'isFavorite': isFavorite}).then((value) {
      selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
      getFavoriteEvents(uId);
    });
  }

  void toggleFavorite(String docId, bool isFavorite, String uId) {
    updateFavorite(docId, !isFavorite, uId);
  }

  List<EventModel> favoriteEvents = [];

  void getFavoriteEvents(String uId) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection(uId)
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

  Future<void> deleteEvent(String docId, String uId) async {
    var collection = await FirebaseUtils.getEventCollection(uId);
    await collection.doc(docId).delete().then((value) {
      selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
      getFavoriteEvents(uId);
    });
  }

  Future<void> updateEvent({
    required String uId,
    required String docId,
    required String image,
    required String eventType,
    required String title,
    required String description,
    required DateTime dateTime,
    required String time,
  }) async {
    var collection = await FirebaseUtils.getEventCollection(uId);
    await collection.doc(docId).update({
      'image': image,
      'eventType': eventType,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
    }).then((value) {
      print('updated Successfully');
      selectedIndex == 0 ? getAllEvents(uId) : getFilteredEvents(uId);
      getFavoriteEvents(uId);
    });
  }
}
