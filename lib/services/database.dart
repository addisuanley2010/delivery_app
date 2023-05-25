import 'dart:js';

import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/customers.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/models/cartModel.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference

  final CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference orderDetailCollection =
      FirebaseFirestore.instance.collection('orderDetail');

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
    String imageUrl,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'imageUrl': imageUrl,
      'role': 'user'
    });
  }

  Future updateUserDataProfile(
    String name,
    String email,
    String phone,
    String address,
    // String image,
    // String role,
  ) async {
    return await customersCollection.doc(uid).update({
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      // 'imageUrl':image,
      // 'role':role,
    });
  }

  //to register new delivery person
  Future addNewDelivery(
    String name,
    String phone,
    String email,
    String address,
    String imageUrl,
    String? uid,
  ) async {
    return await customersCollection.add({
      'name': name,
      'phone': phone,
      'email': email,
      'shopId': uid,
      'address': address,
      'imageUrl': imageUrl,
      'role': 'delivery',
    });
  }
  //return await productCollection.add({

  // order  cart
  Future orderProducts(List<CartItem> cart, double totalAmount) async {
    // return
    //print(' order db called : ${cart}');
    var orderId = await ordersCollection.add({
      'clientId': uid,
      'deliveryId': '',
     // 'addressId': car,
      'shopId': cart[0].shopId,
      'totalCost': totalAmount,
      'status': 'PAID OUT',
      'createdAt': FieldValue.serverTimestamp(),
    });
    //print('${orderId.id}');
    //print('order id: ${orderId}');

    // call add  orderDetail method
    if (orderId.id != null) {
      for (final cartItem in cart) {
        var orderdetailId = await addOrderDetail(cartItem, orderId.id);
        //print(orderdetailId);
        print('order id : ${orderId}');
        // return orderdetailId;
      }
    }
  }

  //  orderDetailCollection  adding
  Future addOrderDetail(CartItem item, var orderId) async {
    // return

    var orderDetailId = await orderDetailCollection.add({
      'orderId': orderId,
      'productId': item.productId,
      'name': item.name,
      'quantity': item.quantity,
      'price': item.price,
      'imageUrl': item.imageUrl,
      'shopId': item.shopId
    });
    print('order detail = ${orderDetailId}');
    return orderDetailId.id;
    //print('order detail id: ${orderDetailId.id}');
  }

  // customer list from snapshot
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
        role: snapshot['role'],
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
    print('get data called');
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
  final String addressId;
  Products({required this.addressId});

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  List<Product> _productsListFromSnapshot(QuerySnapshot snapshot) {
    //print('firebase called');
    //print(snapshot.docs[0].data()); //the data returned is here
    //print(snapshot.docs[1].data()); //the data returned is here
    //print('hello');
    return snapshot.docs.map((doc) {
      //print('doc id: ${doc['imageURL'].trim()}');
      //print('doc data: ${doc.data()}');
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
    // print('get product with address provider called ');
    print('current address= ${addressId}');
    //print('stream called');
    return productsCollection
        .where('addressId', isEqualTo: addressId)
        .snapshots()
        .map(_productsListFromSnapshot);
  }

  //  get product by catagory

  List<Product> _productsListByCatagoryFromSnapshot(QuerySnapshot snapshot) {
    //print('firebase search by catagory');
    // print(snapshot.docs); //the data returned is here
    return snapshot.docs.map((doc) {
      //print('doc id: ${doc.id}');
      // print(doc['imageURL']);
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
    //print('.................');
    //print(catId);
    return productsCollection
        .where('catagory', isEqualTo: catId)
        .snapshots()
        .map(_productsListByCatagoryFromSnapshot);
  }
}
