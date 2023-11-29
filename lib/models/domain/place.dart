import 'package:google_maps/google_maps.dart' show LatLng;

class Place {
  final String id, title, address, type;
  final LatLng position;
  final int distance;

  Place(
      {required this.id,
      required this.title,
      required this.address,
      required this.type,
      required this.position,
      required this.distance});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      title: json['title'],
      address: json['address']['label'],
      type: json['resultType'],
      position: LatLng(json['position']['lat'], json['position']['lng']),
      distance: json['distance'],
    );
  }
}
