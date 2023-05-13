import 'package:delivery/models/customers.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference

  final CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');

  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference catagoryCollection =
      FirebaseFirestore.instance.collection('catagory');

//to add new product
  Future<DocumentReference> updateProductData(
    String name,
    String description,
    String price,
  ) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    return await productCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'shopId': uid,
    });
  }

//to add new catagory
  Future<DocumentReference> addNewCatagory(
    String name,
    String description,
  ) async {
    final catagoryCollection =
        FirebaseFirestore.instance.collection('catagory');
    return await catagoryCollection.add({
      'name': name,
      'description': description,
      'shopId': uid,
    });
  }

//to register new user
  Future updateUserData(
    String name,
    String email,
    String phone,
    String address,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    });
  }

  //to register new delivery person
  Future addNewDelivery(
    String name,
    String lastName,
    String phone,
    String email,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'role': 'delivery',
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





///////////////////////////////////////
