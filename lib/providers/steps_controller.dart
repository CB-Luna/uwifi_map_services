import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';

import '../classes/customer_info.dart';
import '../ui/views/stepsViews/customer_info_view.dart';
import '../ui/views/stepsViews/end_summary.dart';
import '../ui/views/sales_views/sales_view.dart';

import 'package:uwifi_map_services/ui/views/portability_view/popups/popup_acknowledge.dart';
import 'package:uwifi_map_services/ui/views/portability_view/selector_view/selector_summary_view.dart';

enum Views { plansView, customerInfoView, finalSummaryView }

enum RepViews { customerInfoView, plansView, finalSummaryView }

class StepsController with ChangeNotifier {
  Views _index = Views.plansView;
  RepViews _repIndex = RepViews.customerInfoView;

  String _street = '';
  String _state = '';
  String _city = '';
  String _zipcode = '';
  String _serviceType = '';
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
    _serviceType = customer.serviceType;
    notifyListeners();
  }

  changeStep(Views index) {
    switch (index) {
      case Views.plansView:
        return SalesView(serviceType: _serviceType);

      case Views.customerInfoView:
        return CustomerInfoView(
          street: _street,
          city: _city,
          state: _state,
          zipcode: _zipcode,
        );

      case Views.finalSummaryView:
        return EndSummaryWidget(
          street: _street,
          city: _city,
          state: _state,
          zipcode: _zipcode,
        );

      default:
        return SalesView(serviceType: _serviceType);
    }
  }

  changeRepStep(RepViews index) {
    switch (index) {
      case RepViews.plansView:
        return SalesView(serviceType: _serviceType);

      case RepViews.customerInfoView:
        return CustomerInfoView(
          street: _street,
          city: _city,
          state: _state,
          zipcode: _zipcode,
        );

      case RepViews.finalSummaryView:
        return EndSummaryWidget(
          street: _street,
          city: _city,
          state: _state,
          zipcode: _zipcode,
        );

      default:
        return SalesView(serviceType: _serviceType);
    }
  }

  bool formValidation() {
    return formKey.currentState!.validate() ? true : false;
  }

  void promoCheck(bool? value) {
    promoCheckFlag = value ?? false;
    notifyListeners();
  }

  validateRepStep(context) {
    switch (repCurrentStep) {
      case RepViews.plansView:
        popupAcknowledge(context);
        repCurrentStep = RepViews.finalSummaryView;

        break;
      case RepViews.customerInfoView:
        final cartController = Provider.of<Cart>(context, listen: false);
        if (formValidation() && promoCheckFlag) {
          cartController.isSelectedGigFastVoice()
              // ? selectorSummaryview(context)
              ? null
              : 
              null;

          repCurrentStep = RepViews.plansView;
        }
        break;
      case RepViews.finalSummaryView:
        break;
    }

    notifyListeners();
  }

  validateStep(bool cartContains, context) {
    switch (currentStep) {
      case Views.plansView:
        if (cartContains) {
          currentStep = Views.customerInfoView;
        }

        break;
      case Views.customerInfoView:
        final cartController = Provider.of<Cart>(context, listen: false);
        if (formValidation() && promoCheckFlag) {
          cartController.isSelectedGigFastVoice()
              // ? selectorSummaryview(context)
              ? null
              : null;
          // popupAcknowledge(context);
          currentStep = Views.finalSummaryView;
        }
        break;
      case Views.finalSummaryView:
        break;
    }

    notifyListeners();
  }
}
