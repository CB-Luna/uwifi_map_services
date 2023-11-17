// ignore_for_file: avoid_print

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:uwifi_map_services/models/domain/helpers/const.dart';
import 'package:uwifi_map_services/models/geocode.dart';

class GeocodeAPI {
  final Dio _dio;

  GeocodeAPI(this._dio);
  CancelToken? _cancelToken;

  Future<Geocode?> geocode({
    required String street,
    String? city,
    String? state,
    required String zipcode,
  }) async {
    try {
      _cancelToken = CancelToken();
      final String query = _fillQuery(street, city, state, zipcode);
      final Map<String, dynamic> queryParameters = {
        'apiKey': apiKey,
        'qq': query,
      };
      final Response<String> response = await _dio.get(
        'https://geocode.search.hereapi.com/v1/geocode',
        queryParameters: queryParameters,
        cancelToken: _cancelToken,
      );

      final geocode = Geocode.fromJson(response.data!);
      _cancelToken = null;
      return geocode;
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

  void revGeocode() {}

  String _fillQuery(
    String street,
    String? city,
    String? state,
    String zipcode,
  ) {
    String query = '';
    //Street
    query = '${query}street=$street;';
    //City
    if (city != null) {
      query = '${query}city=$city;';
    }
    //State
    if (state != null) {
      query = '${query}state=$state;';
    }
    //Zipcode
    query = '${query}postalCode=$zipcode';
    return query;
  }

  void cancel() {
    if (_cancelToken != null) {
      _cancelToken!.cancel();
      _cancelToken = null;
    }
  }

  void dispose() {
    cancel();
  }
}
