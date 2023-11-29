// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';

class LocationPhoneController extends ChangeNotifier {
  Future<dynamic> getLocationData(zipcode) async {
    try {
      var url = Uri.parse('$env/planbuilder/api');

      final bodyMsg = jsonEncode({
        "apikey": "svsvs54sef5se4fsv",
        "customerID": "null",
        "action": "searchAccountID",
        "zipcode": zipcode
      });

      var response = await http.post(url, body: bodyMsg);

      var result = json.decode(response.body)["result"];

      return result;
    } catch (e) {
      print('ERROR - function getLocationData(): $e');
      return false;
    }
  }
}
