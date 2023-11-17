import 'dart:async';
import 'package:dio/dio.dart';

import 'package:uwifi_map_services/models/domain/helpers/const.dart';
import 'package:google_maps/google_maps.dart' show LatLng$Ext, LatLng;
import 'package:uwifi_map_services/models/domain/place.dart';

class SuggestionsAPI {
  final Dio _dio;

  SuggestionsAPI(this._dio);
  CancelToken? _cancelToken;
  final _controller = StreamController<List<Place>?>.broadcast();
  Stream<List<Place>?> get onResults => _controller.stream;

  void search(String query, LatLng at) async {
    //LatLng es la posicion inicial
    try {
      _cancelToken = CancelToken();
      final response = await _dio.get(
        'https://autosuggest.search.hereapi.com/v1/autosuggest',
        queryParameters: {
          'apiKey': apiKey,
          'q': query,
          'at': '${at.lat},${at.lng}',
          'in': 'countryCode:USA',
          //'types': 'place,street,city,locality,intersection',
          'types': 'street',
        },
        cancelToken: _cancelToken,
      );
      var results = (response.data['items'] as List)
          .map(
            (e) => Place.fromJson(e),
          )
          .toList();
      if (results.length > 5) {
        results = results.sublist(0, 5);
      }
      _controller.sink.add(results);
      _cancelToken = null;
    } on DioError catch (e) {
      if (e.type != DioErrorType.cancel) {
        _controller.sink.add(null);
      }
    }
  }

  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }

  void dispose() {
    cancel();
    _controller.close();
  }
}
