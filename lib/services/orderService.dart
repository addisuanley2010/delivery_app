import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/orderDetailModel.dart';
import 'package:delivery/models/orderModel.dart';
import 'package:delivery/models/orderResponse.dart';
import 'package:delivery/services/database.dart';

class OrderService {
  final String uid;
  OrderService({required this.uid});

  final CollectionReference getOrdersCollection =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference getOrderDetailCollection =
      FirebaseFirestore.instance.collection('orderDetail');

  // get order response for single user/client stream
  Stream<List<Orders>?> get getOrdersByClientId {
    print('get order called');
    //print(uid);
    // print(getOrdersCollection
    //     .where('clientId', isEqualTo: uid)
    //     .snapshots()
    //     .toSet());
    return getOrdersCollection
        .where('clientId', isEqualTo: uid)
        .snapshots()
        .map(_getOrdersListFromSnapshot);
  }

  List<Orders>? _getOrdersListFromSnapshot(QuerySnapshot snapshot) {
    print('change to object called');
    // print(snapshot.docs[1].data());
    // print(snapshot.docs[0].data());
    //print('change to object called');
    //print(snapshot.docs[0].data());
    try {
      return snapshot.docs.map((doc) {
        print(doc.id);
        DateTime createdAt = (doc['createdAt'] as Timestamp)
            .toDate(); // Convert Firestore Timestamp to DateTime
        print(createdAt);
        return Orders(
          orderId: doc.id,
          clientId: doc['clientId'] ?? '',
          deliveryId: doc['deliveryId'] ?? '',
          addressId: doc['addressId'] ?? '',
          //totalCost: doc['totalCost'] ?? 0,
          totalCost: (doc['totalCost'] ?? 0).toDouble(), // Cast to double
          createdAt: createdAt,
          status: doc['status'] ?? '',
        );
      }).toList();
    } catch (e) {
      print('Error mapping orders: $e');
      return null; // or throw the error again if you want to handle it in another part of your code
    }
  }

///////////////////////the below code is for order detail needed for future
  ///
  ///
  ///
  ///
  Stream<List<OrderDetail>> getOrderDetailsById(String orderId) {
    print('getClientOrdersDetail called with orderId: $orderId');
    final snapshots = getOrderDetailCollection
        .where('orderId', isEqualTo: orderId)
        .snapshots();
    // print(snapshots);
    return snapshots.map((snapshot) {
      //snapshots.listen((snapshot) {
      // print(snapshot.docs);
      return (snapshot.docs.map((product) {
        //return product['name'];
        return OrderDetail(
          name: product['name'],
          imageUrl: product['imageUrl'],
          orderId: product['orderId'],
          price: product['price'],
          productId: product['productId'],
          quantity: product['quantity'],
        );
      }).toList());
    });
  }

  //change to order object
  List<OrderDetail> _getOrdersDetailListFromSnapshot(QuerySnapshot snapshot) {
    print('order snaphshot to list called');
    return snapshot.docs.map((doc) {
      print(doc.data);
      return OrderDetail(
        orderId: doc.id,
        name: doc['name'] ?? '',
        price: doc['price'] ?? '',
        quantity: doc['quantity'] ?? '',
        productId: doc['productId'] ?? '',
        imageUrl: doc['imageUrl'] ?? '',
      );
    }).toList();
  }
}

// get orders for delivery
class Delivery {
  final String uid;
  final String status;
  Delivery({required this.uid, required this.status});

  final CollectionReference getOrdersCollection =
      FirebaseFirestore.instance.collection('orders');

  Stream<List<Orders>?> get getOrdersByDeliveryId {
    print('get order from deliveryMan called');

    return getOrdersCollection
        .where('deliveryId', isEqualTo: uid)
        .where('status', isEqualTo: status)
        .snapshots()
        .map(OrderService(uid: uid)._getOrdersListFromSnapshot);
  }

  Future updateOrderStatus(
      {required String orderId, required String status}) async {
    final CollectionReference updateOrdersCollectionStatus =
        FirebaseFirestore.instance.collection('orders');

    await updateOrdersCollectionStatus
        .doc(orderId)
        .update({'status': status}).then((value) {
      print('Order status changed successfully');
    }).catchError((error) {
      print('Failed to Order status: $error');
    });
  }
}
