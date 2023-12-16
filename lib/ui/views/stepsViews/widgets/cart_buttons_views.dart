import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_fail.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_success.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);
  final customerPDSDCCController = Provider.of<CustomerPDSDCCProvider>(context);
  final customerInfoController = Provider.of<CustomerInfoProvider>(context);
  switch (stepsController.currentStep) {
    //Se controla la leyenda del botón del shopping cart, dependiendo la vista actual del proceso.
    case Views.customerInfoView:
      //Se controla la opacidad del botón (que se haga ver habilitado)
      var opacity = 1.0;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Check for Services",
          function: () {
            bool boolPD = customerPDSDCCController.formValidationPD();
            bool boolSD = stepsController.formValidation();
            bool boolACC = customerInfoController.formValidation();
            bool boolCC = customerPDSDCCController.formValidationCC();
            if (boolPD && boolSD && boolACC && boolCC) {
              finalPressed(context, customerPDSDCCController);
            }
          },
          cartContains: cartController.products.isNotEmpty);

    default:
      return const Text("");
  }
}

void finalPressed(BuildContext context,
      CustomerPDSDCCProvider customerPDSDCCController) async {
        try {
          dynamic res;
          var json = {
            "first_name": customerPDSDCCController.parsedFNamePD.text,
              "last_name": customerPDSDCCController.parsedLNamePD.text,
              "email": customerPDSDCCController.parsedEmailPD.text,
              "mobile_phone": customerPDSDCCController.parsedPhonePD.text,
              "address": [
                  {
                      "address_1": customerPDSDCCController.parsedAddress1SD.text,
                      "address_2": null,
                      "zipcode": customerPDSDCCController.parsedZipcodeSD.text,
                      "city": customerPDSDCCController.parsedCitySD.text,
                      "state_code": customerPDSDCCController.parsedStateCodeSD.text,
                      "type": "Physical",
                      "latitude": "${customerPDSDCCController.positionSD?.toJSON()?.lat}",
                      "longitude": "${customerPDSDCCController.positionSD?.toJSON()?.lng}"
                  },
                  {
                      "address_1": customerPDSDCCController.parsedAddress1BD.text,
                      "address_2": null,
                      "zipcode": int.parse(customerPDSDCCController.parsedZipcodeBD.text),
                      "city": customerPDSDCCController.parsedCityBD.text,
                      "state_code": customerPDSDCCController.parsedStateCodeBD.text,
                      "type": "Billing",
                      "latitude": "${customerPDSDCCController.positionBD?.toJSON()?.lat}",
                      "longitude": "${customerPDSDCCController.positionBD?.toJSON()?.lng}"
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
            params: {
              "data" : json
            }
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