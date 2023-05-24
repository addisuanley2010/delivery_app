import 'dart:math';

class Location {
  double latitude;
  double longitude;

  Location(this.latitude, this.longitude);
}

double distanceBetween(Location location1, Location location2) {
  const earthRadius = 6371.0; // in kilometers

  final lat1 = location1.latitude;
  final lon1 = location1.longitude;
  final lat2 = location2.latitude;
  final lon2 = location2.longitude;

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}

void main() {
  Location pointA = Location(37.7749, -122.4194);
  List<Location> places = [
    Location(40.7128, -74.0060),

    Location(41.8781, -87.6298),
    Location(51.5074, -0.1278),

    Location(48.8566, 2.3522),

    Location(37.7749, -122.4194),
    
    Location(35.6895, 139.6917),
  ];

  // Sort the places by their distance from point A
  places.sort((a, b) =>
      distanceBetween(a, pointA).compareTo(distanceBetween(b, pointA)));

  // Display the three closest places to point A
  List<Location> closestPlaces = places.take(3).toList();
  for (int i = 0; i < closestPlaces.length; i++) {
    double distance = distanceBetween(closestPlaces[i], pointA);
    print(
        'Place ${i + 1}: ${closestPlaces[i].latitude}, ${closestPlaces[i].longitude}');
    print('Distance from Point A: $distance km');
  }
}
