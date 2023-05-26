import 'package:flutter/material.dart';

class Address {
  final String id;
  final String name;
  final double lat;
  final double long;
  final double distance;

  Address({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.distance,
  });
}

class AddressController with ChangeNotifier {
  Address _address = Address(id: '', name: '', lat: 0, long: 0, distance: 0);

  Address get address => _address;

  void clear() {
    _address = Address(id: '', name: '', lat: 0, long: 0, distance: 0);
    notifyListeners();
  }

  //int get itemCount => _items.length;

  // double get totalAmount {
  //   double total = 0.0;
  //   for (var item in _items) {
  //     total += (item.price * item.quantity);
  //   }
  //   return total;
  // }

  void setAddress(
    String id,
    String name,
    double lat,
    double long,
  ) {
    // print('set address is called');

    _address = Address(
      id: id,
      name: name,
      lat: lat,
      long: long,
      distance: 0,
    );
  }

  notifyListeners();
}

  // void removeItem(String id) {
  //   _items.removeWhere((item) => item.productId == id);
  //   notifyListeners();
  // }

  // Future placeOrder(String userId) async {
  //   // Code to place the order goes here
  //   //print('user id : ${userId}');

  //   DatabaseService databaseService = DatabaseService(uid: userId);
  //   var orderDetailId = await databaseService.orderProducts(items, totalAmount);

  //   clear();
  //   //print(orderDetailId);
  //   return orderDetailId;
  // }

  // void increaseQuantity(String id) {
  //   //print('increase quantity called');
  //   int index = _items.indexWhere((item) => item.productId == id);
  //   //print(_items[index].quantity);
  //   if (index >= 0) {
  //     _items[index].quantity += 1;
  //     // print(_items[index].quantity);
  //     notifyListeners();
  //   }
  // }

  // void decreaseQuantity(String id) {
  //   //print('decrease quantity called');
  //   int index = _items.indexWhere((item) => item.productId == id);
  //   if (index >= 0) {
  //     if (_items[index].quantity > 1) {
  //       _items[index].quantity -= 1;
  //     } else {
  //       _items.removeAt(index);
  //     }
  //     notifyListeners();
  //   }
  // }

