import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';

import '../classes/product.dart';
import 'package:http/http.dart' as http;

enum Views { map, customerInfo, finalSummary }

class TrackingProvider with ChangeNotifier {
  late String uuid;
  late String origin;
  Views _index = Views.map;

  Views get currentView => _index;

  TrackingProvider(this.uuid) {
    notifyListeners();
  }

  set setView(index) {
    _index = index;
    notifyListeners();
  }

  set setOrigin(originParam) {
    origin = originParam;
    notifyListeners();
  }

  changeViewIndex() {
    switch (currentView) {
      case Views.map:
        _index = Views.customerInfo;
        break;

      case Views.customerInfo:
        _index = Views.finalSummary;
        break;

      case Views.finalSummary:
        break;
    }
    notifyListeners();
  }

  Future<String> recordTrack(
      {List<Product>? services,
      CustomerInfo? customerInfo,
      String? firstName,
      String? lastName,
      String? email,
      String? initialOrigin,
      String? view}) async {
    List<Map<String, dynamic>> servicesList = [];

    final Map<String, dynamic> body = {
      'apikey': 'svsvs54sef5se4fsv',
      'action': 'configuratorTracking',
      'transaction': uuid,
      'page': view ?? currentView.name,
      'origin': initialOrigin ?? (origin != '' ? origin : 'general')
    };

    if (services != null) {
      for (Product product in services) {
        servicesList.add(product.toMap());
      }

      body['services'] = servicesList;
    }

    if (firstName != null || firstName != "") {
      Map<String, dynamic> customer = {
        'firstName': firstName,
        'lastName': lastName,
        'emailAddress': email,
      };

      body['customer'] = customer;
    }

    if (customerInfo != null) {
      Map<String, dynamic> location = {
        'physicalStreet': customerInfo.street,
        'physicalCity': customerInfo.city,
        'physicalState': customerInfo.state,
        'physicalZip': customerInfo.zipcode,
        'networkType': customerInfo.coverageType
      };
      body['location'] = location;
    }

    try {
      // var url = Uri.parse('$env/planbuilder/api');
      var url = Uri.parse('');

      final response = await http.post(
        url,
        body: jsonEncode(body),
      );

      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}
