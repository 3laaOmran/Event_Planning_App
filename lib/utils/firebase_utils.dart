import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/models/event_model.dart';
import 'package:evently_app/utils/models/user_model.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
            fromFirestore: (snapShot, options) =>
                EventModel.fromFireStore(snapShot.data()),
            toFirestore: (event, _) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(EventModel event, String uId) {
    CollectionReference<EventModel> collectionReference =
        getEventCollection(uId);
    DocumentReference<EventModel> documentReference = collectionReference.doc();
    event.id = documentReference.id;
    return documentReference.set(event);
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(UserModel user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> readUserFromFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }
}
