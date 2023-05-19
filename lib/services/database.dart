import 'package:delivery/models/customers.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/models/product.dart';

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
  Future<DocumentReference> addProduct(
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
//  Future<void> addProduct({
//     required String name,
//     required String description,
//     required String price,
//     required String imageUrl,
//     required String category,
//     required String subcategory,
//   }) async {
//     try {
//       final docRef = await productCollection.add({
//         'name': name,
//         'description': description,
//         'price': price,
//         'shopId': uid,
//         'category': category,
//       });
//       await docRef.collection('variants').add({
//         'price': price,
//         'imageUrl': imageUrl,
//         'subcategory': subcategory,
//       });
//     } catch (e) {
//       print('Error adding product: $e');
//     }
//   }

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

// created_at: firebase.firestore.FieldValue.serverTimestamp()
//	state:1,
//role:aibDDjF7ZV5GXzudKena
//imageUrl:

  Future updateUserData(
    String name,
    String email,
    String phone,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'role': 'aibDDjF7ZV5GXzudKena',
      'state': 1,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future updateUserDataProfile(
    String name,
    String email,
    String phone,
    String lastName,
    String address,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'lastName': lastName,
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

///////////////////////////////////////

// catagort list from snapshot
}

class Category {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('catagory');

  List<Catagory> _catagoryListFromSnapshot(QuerySnapshot snapshot) {
    // print('list of addisu');

    return snapshot.docs.map((doc) {
      // print('doc id: ${doc.id}');
      //print('doc data: ${doc.data()}');
      final catagory = Catagory(
        id: doc.id,
        description: doc['description'] ?? '',
        name: doc['name'] ?? '',
      );
      //print('catagory: $catagory');
      return catagory;
    }).toList();
  }

// get catagoty stream
  Stream<List<Catagory>> get catagory1 {
    return categoryCollection.snapshots().map(_catagoryListFromSnapshot);
  }
}

///////////////////////////////////////
