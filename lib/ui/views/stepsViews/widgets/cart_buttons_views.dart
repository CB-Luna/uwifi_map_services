import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_fail.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_success.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);
  final controllerCustomer = Provider.of<CustomerShippingInfo>(context);

  switch (stepsController.currentStep) {
    //Se controla la leyenda del botón del shopping cart, dependiendo la vista actual del proceso.
    case Views.customerInfoView:
      //Se controla la opacidad del botón (que se haga ver habilitado)
      var opacity = 1.0;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Save & Finish",
          function: () {
            if (controllerCustomer.formValidation() && stepsController.formValidation()) {
              finalPressed(context, controllerCustomer);
            }
          },
          cartContains: cartController.products.isNotEmpty);

    default:
      return const Text("");
  }
}

void finalPressed(BuildContext context,
      CustomerShippingInfo controllerCustomer) async {
        try {
          dynamic res;
          var json = {
            "first_name": controllerCustomer.parsedFNamePD.text,
              "last_name": controllerCustomer.parsedLNamePD.text,
              "email": controllerCustomer.parsedEmailPD.text,
              "mobile_phone": controllerCustomer.parsedPhonePD.text,
              "address": [
                  {
                      "address_1": controllerCustomer.parsedAddress1PD.text,
                      "address_2": null,
                      "zipcode": controllerCustomer.parsedZipcodePD.text,
                      "city": controllerCustomer.parsedCityPD.text,
                      "state_code": "TX",
                      "type": "Physical",
                      "latitude": controllerCustomer.locatizationPD?.lat.toString(),
                      "longitude": controllerCustomer.locatizationPD?.lng.toString()
                  },
                  {
                      "address_1": controllerCustomer.parsedAddress1SD.text,
                      "address_2": null,
                      "zipcode": int.parse(controllerCustomer.parsedZipcodeSD.text),
                      "city": controllerCustomer.parsedCitySD.text,
                      "state_code": "TX",
                      "type": "Billing",
                      "latitude": controllerCustomer.locatizationSD?.lat.toString(),
                      "longitude": controllerCustomer.locatizationSD?.lng.toString()
                  }
              ],
              "services": [
                  {
                      "service_id": 1
                  }
              ]
          };

          res = await supabase.rpc(
            'create_lead',
            params: json
          );

          if (res != null) {
            // ignore: use_build_context_synchronously
            showDialog(
              barrierColor: const Color(0x00022963).withOpacity(0.40),
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const FinalPopupSuccess();
              },
            );
          } else {
            // ignore: use_build_context_synchronously
            showDialog(
              barrierColor: const Color(0x00022963).withOpacity(0.40),
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const FinalPopupFail();
              },
            );
          }
        } catch (error) {
          print("Error on Final Pressed: '$error'");
          // ignore: use_build_context_synchronously
            showDialog(
              barrierColor: const Color(0x00022963).withOpacity(0.40),
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return const FinalPopupFail();
              },
            );
        }
  }