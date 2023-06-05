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

    const currentLat = 11.596382;
    //    const currentLat = 11.5963826;
//    const currentLon = 37.3955301;
    const currentLon = 37.395530;

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
        final addressLat = (doc['latitude'] ?? 0).toDouble();
        final addressLon = (doc['longitude'] ?? 0).toDouble();

        final calculatedDistance =
            distanceBetween(currentLat, currentLon, addressLat, addressLon);

        return Address(
          id: doc.id,
          name: doc['name'] ?? '',
          lat: addressLat,
          long: addressLon,
          distance: calculatedDistance,
        );
      }).toList();
    } catch (e) {
      print('Error mapping orders: $e');
      return null;
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
class L {
  Future<Mylocation> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return Mylocation(
      lat: position.latitude,
      long: position.longitude,
    );
  }
}

// insert location data in to location collection
class LocationInsert {
  Future<String?> addAdress({
    required double latitude,
    required double longitude,
    required String name,
  }) async {
    print('insert address called, at it');
    // Create a new document reference in the "address" collection
    DocumentReference addressRef =
        FirebaseFirestore.instance.collection('address').doc();

    // Create a data map with the latitude and longitude
    Map<String, dynamic> addressData = {
      'latitude': latitude,
      'longitude': longitude,
      'name': name
    };

    try {
      // Insert the address data into the Firestore collection
      await addressRef.set(addressData);
      return addressRef.id; // Return the document ID of the inserted data
    } catch (error) {
      print('Error inserting address: $error');
      return null;
    }
  }
}
