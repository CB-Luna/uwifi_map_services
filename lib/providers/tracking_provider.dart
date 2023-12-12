import 'package:flutter/material.dart';

enum Views { map, customerInfo, finalSummary }

class TrackingProvider with ChangeNotifier {
  late String uuid;
  // late String origin;
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

}
