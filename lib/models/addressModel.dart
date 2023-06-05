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
