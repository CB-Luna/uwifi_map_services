import 'package:google_maps/google_maps.dart' show LatLng;
import 'package:uwifi_map_services/models/domain/place.dart';

abstract class SuggestionsRepository {
  Stream<List<Place>?> get onResults;
  void cancel();
  void dispose();
  void search(String query, LatLng at);
}
