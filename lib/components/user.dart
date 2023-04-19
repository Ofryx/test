import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String email;
  String displayName;

  User({required this.uid, required this.email, required this.displayName});

  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return User(
      uid: snapshot.id,
      email: data!['email'] as String,
      displayName: data['displayName'] as String,
    );
  }
}
