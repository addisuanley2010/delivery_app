import 'package:delivery/models/customers.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/models/product.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

// database reference
  // FirebaseFirestore db = FirebaseFirestore.instance;

  // collection reference
  final CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');

  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference catagoryCollection =
      FirebaseFirestore.instance.collection('catagory');

  Future<DocumentReference> updateProductData(
    String name,
    String description,
    double price,
  ) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    return await productCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'shopId': uid,
      // 'picture': 'assets/phone/iphone.png'
    });
  }

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

// catagort list from snapshot
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

// catagort list from snapshot
class Products {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    print('firebase called');
    //print(snapshot.docs[5].data()); //the data returned is here
    return snapshot.docs.map((doc) {
      //print('doc id: ${doc.id}');
      //print('doc data: ${doc.data()}');
      // String url =
      //     "   https://firebasestorage.googleapis.com/v0/b/deliver-d327d.appspot.com/o/addisu.jpeg?alt=media&token=726b56e8-c4c5-4b40-aed3-324f596f1de7";
      // String trimmedUrl = url.trim(); // remove extra white space characters

      final productsList = Product(
        id: doc.id,
        name: doc['name'] ?? '',
        catagoryId: doc['catagory'] ?? '',
        picture: doc['imageURL'].trim() ?? '',
        description: doc['description'] ?? '',
        shopeId: doc['shopId'] ?? '',
        price: doc['price'] ?? 0.0,
        status: doc['status'] ?? '',
      );
      print('product: $productsList');
      return productsList;
    }).toList();
  }

// get catagoty stream
  Stream<List<Product>> get productsList {
    print('stream called');
    return productsCollection.snapshots().map(_productsListFromSnapshot);
  }
}
