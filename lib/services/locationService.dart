import 'package:delivery/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

Future<Mylocation> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
  return Mylocation(
    lat: position.latitude,
    long: position.longitude,
  );
}
