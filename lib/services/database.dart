import 'package:delivery/models/customers.dart';
import 'package:delivery/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

// database reference
  // FirebaseFirestore db = FirebaseFirestore.instance;

  // collection reference
  final CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');

  Future updateUserData(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    print('collection method');
    print(uid);
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });
  }

  // brew list from snapshot
  List<Customers> _customersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Customers(
          name: doc['name'] ?? '',
          email: doc['email'] ?? '',
          phone: doc['phone'] ?? '',
          address: doc['address'] ?? '');
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        address: snapshot['address']);
  }

  // get brews stream
  Stream<List<Customers>> get customers {
    return customersCollection.snapshots().map(_customersListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return customersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
