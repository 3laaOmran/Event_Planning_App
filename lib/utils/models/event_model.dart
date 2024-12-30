class EventModel {
  static const collectionName = 'Events';
  String id;
  String image;
  String eventType;
  String title;
  String description;
  DateTime dateTime;
  String time;
  bool isFavorite;

  EventModel(
      {this.id = '',
      required this.image,
      required this.eventType,
      required this.title,
      required this.description,
      required this.dateTime,
      required this.time,
      this.isFavorite = false});

  ///object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'image': image,
      'eventType': eventType,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'time': time,
      'isFavorite': isFavorite
    };
  }

  // json => object
  EventModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!['id'] as String,
          image: data['image'] as String,
          eventType: data['eventType'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
          time: data['time'] as String,
          isFavorite: data['isFavorite'] as bool,
        );
}
