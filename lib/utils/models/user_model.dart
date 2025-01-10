class UserModel {
  static const String collectionName = 'Users';
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.name, required this.email});

  // json => object
  UserModel.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data!['id'] as String,
          name: data['name'] as String,
          email: data['email'] as String,
        );

//object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
