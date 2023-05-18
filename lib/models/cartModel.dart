import 'dart:async';

import 'package:flutter/material.dart';

class CartItem {
  final String productId;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.quantity = 0,
  });
}

class Cart {
  List<CartItem> _items = [];
  StreamController<List<CartItem>> _itemsController =
      StreamController<List<CartItem>>.broadcast();
  Map<String, StreamController<CartItem>> _itemControllers = {};

  Stream<List<CartItem>> get itemsStream => _itemsController.stream;

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  void addItem(String id, String name, double price) {
    print('add item is called');
    print(price);
    int index = _items.indexWhere((item) => item.productId == id);
    if (index >= 0) {
      // _items[index].quantity += 1;
    } else {
      _items
          .add(CartItem(productId: id, name: name, price: price, quantity: 0));
    }
    _itemsController.add(_items);
    print(_items.length);
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.productId == id);
    _itemsController.add(_items);
  }

  void clear() {
    _items = [];
    _itemsController.add(_items);
  }

  void placeOrder() {
    // Code to place the order goes here
    clear();
  }

  Stream<CartItem>? getItemStream(String id, String name) {
    print('get cartitem stream called');
    //print(name);
    if (!_itemControllers.containsKey(id)) {
      //print(name);
      _itemControllers[id] = StreamController<CartItem>.broadcast();
    }
    //print(name);
    try {
      //print(name);

      var item = _items.firstWhere((item) => item.productId == id);
      _itemControllers[id]!.add(item);
      print(name);

      print('current item');
      print(_itemControllers[id]!.stream);
      return _itemControllers[id]!.stream;
    } on StateError {
      return null;
    }
  }

  void disposeItemStream(String id) {
    if (_itemControllers.containsKey(id)) {
      _itemControllers[id]!.close();
      _itemControllers.remove(id);
    }
  }

  void increaseQuantity(String id) {
    print('increase quantity called');
    int index = _items.indexWhere((item) => item.productId == id);
    if (index >= 0) {
      _items[index].quantity += 1;
      _itemsController.add(_items);
    }
  }

  void decreaseQuantity(String id) {
    print('decrease quantity called');
    int index = _items.indexWhere((item) => item.productId == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      _itemsController.add(_items);
    }
  }
}
