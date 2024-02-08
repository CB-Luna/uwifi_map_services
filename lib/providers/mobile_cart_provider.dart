import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/full_form_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart_summary_widget.dart';

class MobileCartProvider extends ChangeNotifier {


   bool validateForm(GlobalKey<FormState> vehicleKey) {
    return vehicleKey.currentState!.validate() ? true : false;
  }

  int valueBodyOption = 0;



  void changeBodyOption() {
    if (valueBodyOption == 0) {
      valueBodyOption = 1;
    } else {
      valueBodyOption = 0;
    }
    notifyListeners();
  }

  Widget optionBodySection() { 
  switch (valueBodyOption) {
      case 0:
        return const FullFormWidget();
      case 1:
        return const CartSummaryWidget();
      default:
        return const FullFormWidget();
    }
  }

  void clean() {
    valueBodyOption = 0;
    notifyListeners();
  }

}
