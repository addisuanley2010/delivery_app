import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/customers.dart';
import 'package:delivery/models/product.dart';
import 'package:delivery/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/ui/client/component/product.dart';
import 'package:delivery/models/cartModel.dart';

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
    int intAmount,
    String category,
    String url,
  ) async {
    final productCollection = FirebaseFirestore.instance.collection('products');
    return await productCollection.add({
      'name': name,
      'description': description,
      'price': price,
      'amount': intAmount,
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
      'role': 'user',
      'status': 'approved',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //update Admin data at customer collection

  Future updateAdminData(
    String name,
    String email,
    String phone,
    String imageUrlLiscence,
    String? region,
    String? zone,
    String? wereda,
    String? kebele,
    String? friendlyAddress,
    String? imageUrlAddress,
    String? houseNumber,
    String? addressId,
  ) async {
    return await customersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'imageUrlLiscence': imageUrlLiscence,
      'imageUrl': imageUrlAddress,
      'region': region,
      'zone': zone,
      'wereda': wereda,
      'kebele': kebele,
      'friendlyAddress': friendlyAddress,
      'imageUrlAddress': imageUrlAddress,
      'houseNumber': houseNumber,
      'role': 'admin',
      'address': kebele,
      'addressId': addressId,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
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

  Future updateProductData(
    String productID,
    String name,
    String description,
    double price,
    int amount,
    // String image,
    // String role,
  ) async {
    return await productCollection.doc(productID).update({
      'name': name,
      'description': description,
      'price': price,
      'amount': amount,
      // 'imageUrl':image,
      // 'role':role,
    });
  }

  Future updateProductStatus(
    String productId,
    String status,
  ) async {
    return await productCollection.doc(productId).update({
      'status': status,
    });
  }

  //to register new delivery person
  Future addNewDelivery(
    String name,
    String phone,
    String email,
    String address,
    String imageUrl,
    String? uidDelivery,
  ) async {
    return await customersCollection.doc(uidDelivery).set({
      'name': name,
      'phone': phone,
      'email': email,
      'shopId': uid,
      'address': address,
      'imageUrl': imageUrl,
      'role': 'delivery',
      'createdAt': FieldValue.serverTimestamp(),
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
      'addressId': '',
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

        await productCollection.doc(cartItem.productId).update(
            {'amount': FieldValue.increment(-cartItem.quantity)}).then((value) {
          print('Product amount decreased successfully');
        }).catchError((error) {
          print('Failed to decrease product amount: $error');
        });

        final DocumentSnapshot productSnapshot =
            await productCollection.doc(cartItem.productId).get();

        final Map<String, dynamic>? productData =
            productSnapshot.data() as Map<String, dynamic>?;
        print('hello${productData}');
        if (productData != null) {
          if (productData['amount'] == 0) {
            print('product amount is 0');
            productCollection
                .doc(cartItem.productId)
                .update({'status': 'sold'}).then((value) {
              print('status changed to sold successfully');
            }).catchError((error) {
              print('Failed to decrease product amount: $error');
            });
          } else {
            print('product amount is not 0');
          }
        }
      }
    }
  }

  //  orderDetailCollection  adding
  Future addOrderDetail(CartItem item, var orderId) async {
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
    print('change to object');
    print(uid);
    print(UserData(
        uid: uid,
        role: snapshot['role'],
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
        address: snapshot['address']));
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
    print('user id : $uid');
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

// get product stream
  Stream<List<Product>> get productsListByAddress {
    // print('get product with address provider called ');
    print('current address for single shop= ${addressId}');
    //print('stream called');
    // print(productsCollection
    //     .where('status', isEqualTo: 'not sold')
    //     .where('addressId', isEqualTo: addressId)
    //     .snapshots());
    return productsCollection
        .where('status', isEqualTo: 'not sold')
        // .where('shopId', isEqualTo: addressId)
        .snapshots()
        .map(_productsListFromSnapshot);
  }

  Stream<List<Product>> get productsAllList {
    // print('get product with address provider called ');
    print('current address= ${addressId}');
    //print('stream called');
    return productsCollection
        .where('status', isEqualTo: 'not sold')
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

// check inventory
class Inventory {
  // final String productId;
  // Inventory({required this.productId});

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<String?> checkInventoryFromCart(List<CartItem> items) async {
    String available = '';

    for (CartItem cartItem in items) {
      final DocumentSnapshot productSnapshot =
          await productsCollection.doc(cartItem.productId).get();

      final Map<String, dynamic>? productData =
          productSnapshot.data() as Map<String, dynamic>?;

      if (productData != null) {
        final int remainingQuantity = productData['amount'];

        if (cartItem.quantity > remainingQuantity) {
          available = cartItem.productId;
          break;
        }
      }
    }
    return available;
  }

  ////  check quantity when  a user clicks increase quantity button
  Future<String> checkInventoryFromIncreaseQuantity(
      String productId, int quantity) async {
    String isAvailable = 'true';

    DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();
    final Map<String, dynamic>? productData =
        productSnapshot.data() as Map<String, dynamic>?;

    if (productData != null) {
      final int remainingQuantity = productData['amount'];

      if (quantity >= remainingQuantity) {
        isAvailable = 'false';
      }
    }
    return isAvailable;
  }
}
