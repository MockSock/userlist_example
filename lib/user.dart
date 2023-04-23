import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  int age;

  User({required this.name, required this.email, required this.age});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
      name: data['name'],
      email: data['email'],
      age: data['age'],
    );
  }
}
