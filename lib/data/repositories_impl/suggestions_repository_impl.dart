import 'package:google_maps/google_maps.dart' show LatLng;
import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/models/domain/repositories/suggestions_repository.dart';
import 'package:uwifi_map_services/providers/remote/suggestions_api.dart';

class SuggestionsRepositoryImpl implements SuggestionsRepository {
  final SuggestionsAPI _searchAPI;

  SuggestionsRepositoryImpl(this._searchAPI);

  @override
  void search(String query, LatLng at) {
    _searchAPI.search(query, at);
  }

  @override
  void cancel() {
    _searchAPI.cancel();
  }

  @override
  void dispose() {
    _searchAPI.dispose();
  }

  @override
  Stream<List<Place>?> get onResults => _searchAPI.onResults;
}
