import 'package:delivery/services/database.dart';
import 'package:flutter/foundation.dart';
import 'package:delivery/models/product.dart';

class CartItem {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;
  String shopId;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.shopId,
  });
}
//cartController

class CartController with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += (item.price * item.quantity);
    }
    return total;
  }

  void addItem(
      String id, String name, double price, String imageUrl, String shopId) {
    // print('add item is called');

    int index = _items.indexWhere((item) => item.productId == id);
    //print('index = ${index}');
    if (index >= 0) {
      // print('item found in the cart list');
      // _items[index].quantity += 1;
    } else {
      //print('item not found in the cart list, it is added');
      _items.add(CartItem(
          productId: id,
          name: name,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
          shopId: shopId));
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.productId == id);
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }

  Future placeOrder(String userId) async {
    // Code to place the order goes here
    //print('user id : ${userId}');

    DatabaseService databaseService = DatabaseService(uid: userId);
    var orderDetailId = await databaseService.orderProducts(items, totalAmount);

    clear();
    //print(orderDetailId);
    return orderDetailId;
  }

  void increaseQuantity(String id) {
    //print('increase quantity called');
    int index = _items.indexWhere((item) => item.productId == id);
    //print(_items[index].quantity);
    if (index >= 0) {
      _items[index].quantity += 1;
      // print(_items[index].quantity);
      notifyListeners();
    }
  }

  void decreaseQuantity(String id) {
    //print('decrease quantity called');
    int index = _items.indexWhere((item) => item.productId == id);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }
}
