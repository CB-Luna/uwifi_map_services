import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/form_view.dart';

import '../classes/customer_info.dart';
import '../ui/views/stepsViews/customer_info_view.dart';

enum Views { customerInfoView}

enum RepViews { customerInfoView}

class StepsController with ChangeNotifier {
  Views _index = Views.customerInfoView;
  RepViews _repIndex = RepViews.customerInfoView;

  String _street = '';
  String _state = '';
  String _city = '';
  String _zipcode = '';
  bool promoCheckFlag = false;
  bool formValidated = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Views get currentStep => _index;
  RepViews get repCurrentStep => _repIndex;

  set currentStep(index) {
    _index = index;

    notifyListeners();
  }

  set repCurrentStep(index) {
    _repIndex = index;

    notifyListeners();
  }

  StepsController(CustomerInfo customer) {
    _street = customer.street;
    _state = customer.state;
    _city = customer.city;
    _zipcode = customer.zipcode;
    notifyListeners();
  }

  changeStep(Views index) {
    switch (index) {

      case Views.customerInfoView:
        return CustomerInfoView(
          street: _street,
          city: _city,
          state: _state,
          zipcode: _zipcode,
        );

      default:
        return const FormView();
    }
  }


  bool formValidation() {
    return formKey.currentState!.validate() ? true : false;
  }

  void promoCheck(bool? value) {
    promoCheckFlag = value ?? false;
    notifyListeners();
  }


  validateStep(bool cartContains, context) {
    switch (currentStep) {
      case Views.customerInfoView:
        final cartController = Provider.of<Cart>(context, listen: false);
        if (formValidation() && promoCheckFlag) {
          cartController.isSelectedGigFastVoice()
              // ? selectorSummaryview(context)
              ? null
              : null;
          // popupAcknowledge(context);
          currentStep = Views.customerInfoView;
        }
        break;
    }

    notifyListeners();
  }
}
