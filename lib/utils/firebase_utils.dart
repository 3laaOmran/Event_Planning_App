import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/utils/models/event_model.dart';

class FirebaseUtils {
  static CollectionReference<EventModel> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(EventModel.collectionName)
        .withConverter<EventModel>(
            fromFirestore: (snapShot, options) =>
                EventModel.fromFireStore(snapShot.data()),
            toFirestore: (event, _) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(EventModel event) {
    CollectionReference<EventModel> collectionReference = getEventCollection();
    DocumentReference<EventModel> documentReference = collectionReference.doc();
    event.id = documentReference.id;
    return documentReference.set(event);
  }
}
