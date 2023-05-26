import 'dart:math';

import 'package:delivery/models/addressModel.dart';
import 'package:delivery/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/models/orderDetailModel.dart';

class ListShopesService {
  final String uid;
  ListShopesService({required this.uid});

  final CollectionReference getAddressCollection =
      FirebaseFirestore.instance.collection('address');
  final CollectionReference getOrderDetailCollection =
      FirebaseFirestore.instance.collection('orderDetail');

  // get address list
  Stream<List<Address>?> get getAddress {
    print('get address called');
    print(uid);

    const currentLat = 52.132633;
    const currentLon = 5.291266;

    final addressList = getAddressCollection.snapshots().map((snapshot) {
      return _getAddressListFromSnapshot(snapshot, currentLat, currentLon)!
        ..sort((a, b) => a.distance.compareTo(b.distance));
    });

    return addressList;
  }

  List<Address>? _getAddressListFromSnapshot(
      QuerySnapshot snapshot, double currentLat, double currentLon) {
    print('change to object called');
    try {
      return snapshot.docs.map((doc) {
        final addressLat = doc['latitude'] ?? 0.0;
        final addressLon = doc['longitude'] ?? 0.0;

        //const distanceString = 0.0; // Assume distance is stored as a String
        // const distance = distanceString??
        //     0.0; // Convert distance to double

        final calculatedDistance = distanceBetween(currentLat, currentLon,
            addressLat, addressLon); // Calculate the distance

        return Address(
          id: doc.id,
          name: doc['name'] ?? '',
          lat: addressLat.toDouble(),
          long: addressLon.toDouble(),
          distance:
              calculatedDistance, // Assign the calculated distance as a property
        );
      }).toList();
    } catch (e) {
      print('Error mapping orders: $e');
      return null; // or throw the error again if you want to handle it in another part of your code
    }
  }

  double distanceBetween(double lat1, double lon1, double lat2, double lon2) {
    print('distance between called');
    const earthRadiusKm = 6371;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final lat1Radians = _degreesToRadians(lat1);
    final lat2Radians = _degreesToRadians(lat2);

    final a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) * cos(lat1Radians) * cos(lat2Radians);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    print((earthRadiusKm * c).toStringAsFixed(2));
    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
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
