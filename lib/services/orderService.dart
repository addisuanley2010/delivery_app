import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/orderDetailModel.dart';
import 'package:delivery/models/orderModel.dart';
import 'package:delivery/models/orderResponse.dart';

class OrderService {
  final String uid;
  OrderService({required this.uid});

  final CollectionReference getOrdersCollection =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference getOrderDetailCollection =
      FirebaseFirestore.instance.collection('orderDetail');

  // get order response for single user/client stream
  Stream<List<Orders>> get getOrdersByClientId {
    print('get order called');
    print(uid);
    return getOrdersCollection
        .where('clientId', isEqualTo: uid)
        .snapshots()
        .map(_getOrdersListFromSnapshot);
  }

  //change to order object
  List<Orders> _getOrdersListFromSnapshot(QuerySnapshot snapshot) {
    print(snapshot.docs[0].data());

    return snapshot.docs.map((doc) {
      DateTime createdAt = (doc['createdAt'] as Timestamp)
          .toDate(); // Convert Firestore Timestamp to DateTime

      return Orders(
        orderId: doc.id,
        clientId: doc['clientId'] ?? '',
        deliveryId: doc['deliveryId'] ?? '',
        addressId: doc['addressId'] ?? '',
        totalCost: doc['totalCost'] ?? 0,
        createdAt: createdAt,
        status: doc['status'] ?? '',
      );
    }).toList();
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

  //

  //
}
