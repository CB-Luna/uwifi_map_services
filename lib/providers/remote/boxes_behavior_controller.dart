import 'package:flutter/material.dart';

class BoxesBehavior extends ChangeNotifier {
  bool isCartVisible = true;
  bool isPromosListVisible = true;

  BoxesBehavior(bool mobile) {
    mobile ? isCartVisible = false : isCartVisible = true;
    if (mobile) isPromosListVisible = false;
    notifyListeners();
  }

  void changeCartVisibility() {
    isCartVisible = !isCartVisible;
    notifyListeners();
  }

  void changePromosListVisibility() {
    isPromosListVisible = !isPromosListVisible;
    notifyListeners();
  }
}
