import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a function that returns a stream of orders for the current client

Stream<List<Order>> getClientOrders(String uid) {
  // Get the current client's ID
  String clientId = FirebaseAuth.instance.currentUser!.uid;

  // Return a stream of orders for this client
  return FirebaseFirestore.instance
      .collection('orders')
      .where('clientId', isEqualTo: clientId)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Order.fromSnapshot(doc)).toList());
}

// Define a class to hold order data
class Order {
  final String clientId;
  final String deliveryId;
  final String addressId;
  final String status;
  final double totalCost;
  final DateTime createdAt;
  final List<OrderDetail> orderDetails;

  Order({
    required this.clientId,
    required this.deliveryId,
    required this.addressId,
    required this.status,
    required this.totalCost,
    required this.createdAt,
    required this.orderDetails,
  });

  // Define a factory constructorto create Order objects from document snapshots
  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var orderDetailsData = data['orderDetails'] as List<dynamic>;
    var orderDetails =
        orderDetailsData.map((detail) => OrderDetail.fromMap(detail)).toList();
    return Order(
      clientId: data['clientId'],
      deliveryId: data['deliveryId'],
      addressId: data['addressId'],
      status: data['status'],
      totalCost: data['totalCost'],
      createdAt: data['createdAt'].toDate(),
      orderDetails: orderDetails,
    );
  }
}

// Define a class to hold order detail data
class OrderDetail {
  final int orderId;
  final int name;
  final int price;
  final int quantity;
  final String productId;
  final String imageUrl;

  OrderDetail({
    required this.orderId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.imageUrl,
  });

  // Define a factory constructor to create OrderDetail objects from map data
  factory OrderDetail.fromMap(Map<String, dynamic> data) {
    return OrderDetail(
      orderId: data['orderId'],
      name: data['name'],
      price: data['price'],
      quantity: data['quantity'],
      productId: data['productId'],
      imageUrl: data['imageUrl'],
    );
  }
}
