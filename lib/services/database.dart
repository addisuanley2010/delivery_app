import 'package:delivery/models/customers.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/client/component/product.dart';

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
    double price,
    String category,
    String url,
  ) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    return await productCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'shopId': uid,
      'catagory': category,
      'imageURL': url,
      'status': 'not sold'
    });
  }
//oh my god

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

////////////////////////
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
      //print('product: $productsList');
      return productsList;
    }).toList();
  }

// get catagoty stream
  Stream<List<Product>> get productsList {
    //print('stream called');
    return productsCollection.snapshots().map(_productsListFromSnapshot);
  }

  //  get product by catagory

  List<Product> _productsListByCatagoryFromSnapshot(QuerySnapshot snapshot) {
    print('firebase search by catagory');
    print(snapshot.docs); //the data returned is here
    return snapshot.docs.map((doc) {
      //print('doc id: ${doc.id}');
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

// get product  by catagory stream
  Stream<List<Product>> productsListByCatagory(String catId) {
    print('.................');
    print(catId);
    return productsCollection
        .where('catagory', isEqualTo: catId)
        .snapshots()
        .map(_productsListByCatagoryFromSnapshot);
  }
}
