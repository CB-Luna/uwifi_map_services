import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uwifi_map_services/data/constants.dart';
import '../classes/product.dart';
import 'package:uwifi_map_services/classes/products_voice_popup.dart';

enum View { planDetails, portabilityView }

class VoicePopupController extends ChangeNotifier {
  View currentView = View.planDetails;
  late ProductsVoicePopup productsVoicePopup;
  bool getFees = false;
  Map<String, List> aditionalProducts = {};
  List<Product> fees = [];

  Map<String, ProductsVoicePopup> apiResults = {};

  void init() {
    currentView = View.planDetails;
  }

  void changeView(int id) {
    switch (id) {
      case 0:
        currentView = View.planDetails;
        break;
      case 1:
        currentView = View.portabilityView;
        break;
      default:
        currentView = View.planDetails;
        break;
    }
    notifyListeners();
  }

  Future<String> getProductsVoice(String idVoice, String category) async {
    if (apiResults.containsKey(idVoice)) {
      return 'Success getProductsVoice';
    } else {
      try {
        var url = Uri.parse('$env/planbuilder/api');

        final bodyMsg = jsonEncode({
          "apikey": "svsvs54sef5se4fsv",
          "action": "productBySKU",
          "sku": idVoice
        });

        var response = await http.post(url, body: bodyMsg);

        productsVoicePopup = ProductsVoicePopup.fromJson(response.body);
        aditionalProducts[idVoice] =
            productsVoicePopup.result.associations.upsell.products;

        if (productsVoicePopup.result.identifier.isEmpty) {
          return 'None';
        } else {
          apiResults[idVoice] = productsVoicePopup;
          getFeesVoice(category);
          return 'Success getProductsVoice';
        }
      } catch (e) {
        // ignore: avoid_print
        print('Exception on GetProductVoice: $e');
        return 'None';
      }
    }
  }

  void getFeesVoice(String category) {
    if (getFees == false) {
      final localFees = productsVoicePopup.result.associations.fees.products;
      for (var i = 0; i < localFees.length; i++) {
        Product feeVoice = Product(
          id: localFees[i].id,
          name: localFees[i].name,
          cost: double.parse(localFees[i].price),
          service: localFees[i].family,
          category: category,
          index: 0,
          isSelected: true,
          quantity: 1,
          pwName: localFees[i].pwName,
        );
        fees.add(feeVoice);
      }

      getFees = true;
    }
  }

  void clearCallToAPIs() {
    apiResults.clear();
    aditionalProducts.clear();
    fees.clear();
    getFees = false;
    notifyListeners();
  }
}
