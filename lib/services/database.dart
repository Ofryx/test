import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference misisCollection = FirebaseFirestore.instance.collection("misis");

  Future<void> updateUserData(String students, String name, String group) async{
    return await misisCollection.doc(uid).set({
      'students': students,
      'name': name,
      'group': group
    });
  }
}
