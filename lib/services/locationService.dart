import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/orderDetailModel.dart';
import 'package:delivery/models/orderModel.dart';

class ListShopesService {
  final String uid;
  ListShopesService({required this.uid});

  final CollectionReference getAddressCollection =
      FirebaseFirestore.instance.collection('address');
  final CollectionReference getOrderDetailCollection =
      FirebaseFirestore.instance.collection('orderDetail');

  // get address list
  Stream<List<Address>> get getAddress {
    print('get address called');
    print(uid);
    return getAddressCollection.snapshots().map(_getAddressListFromSnapshot);
  }

  //change to Adress object
  List<Address> _getAddressListFromSnapshot(QuerySnapshot snapshot) {
    print(snapshot.docs[0].data());

    return snapshot.docs.map((doc) {
      return Address(
        id: doc.id,
        name: doc['name'] ?? '',
        lat: doc['latitude'] ?? '',
        long: doc['longitude'] ?? '',
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

////////////////
///
///

Future<Mylocation> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return Mylocation(
    lat: position.latitude,
    long: position.longitude,
  );
}
