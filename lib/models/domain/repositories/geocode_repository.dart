import 'package:google_maps/google_maps.dart' show LatLng;
import 'package:uwifi_map_services/models/geocode.dart';

abstract class GeocodeRepository {
  void cancel();
  void dispose();
  Future<Geocode?> geocode({
    required String street,
    String? city,
    String? state,
    required String zipcode,
  });
  void revGeocode(String query, LatLng at);
}
