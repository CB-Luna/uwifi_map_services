import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:uwifi_map_services/helpers/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_fail.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup_success.dart';
import '../../../../../providers/cart_controller.dart';
import '../../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);
  final customerPDSDController = Provider.of<CustomerPDSDProvider>(context);
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
          buttonText: "Checkout | \$${cartController.total}",
          function: () {
            if (customerPDSDCCController.sameAsSD) {
              bool boolPD = customerPDSDController.formValidationPD();
              bool boolSD = stepsController.formValidation();
              bool boolCC = customerPDSDCCController.formValidationCC();
                if (boolPD && boolSD && boolCC) {
                  finalPressed(context, customerPDSDController, customerPDSDController, customerPDSDCCController, true, cartController.total);
                }
            } else {
              bool boolPD = customerPDSDController.formValidationPD();
              bool boolSD = stepsController.formValidation();
              bool boolPAD = customerInfoController.formValidation();
              bool boolCC = customerPDSDCCController.formValidationCC();
              if (boolPD && boolSD && boolPAD && boolCC) {
                finalPressed(context, customerPDSDController, customerPDSDController, customerPDSDCCController, false, cartController.total);
              }
            }
          },
          cartContains: cartController.services.isNotEmpty);

    default:
      return const Text("");
  }
}

void finalPressed(BuildContext context, CustomerPDSDProvider controllerPesonalD, CustomerPDSDProvider controllerShippingD, CustomerPDSDCCProvider controllerPaymentD, bool sameAsSD, double total) async {
    try {
      //Se crea el API para Registrar Usuario
      final headers = ({
        "Content-Type": "application/json",
      });
      var jsonAPI = {};
      if (sameAsSD) {
        final address2SD = (controllerShippingD.parsedAddress2SD.text == "" || 
        controllerShippingD.parsedAddress2SD.text.isEmpty) ?
        null
        :
        controllerShippingD.parsedAddress2SD.text;
        jsonAPI = {
          "first_name": controllerPesonalD.parsedFNamePD.text,
          "last_name": controllerPesonalD.parsedLNamePD.text,
          "email": controllerPesonalD.parsedEmailPD.text,
          "mobile_phone": controllerPesonalD.parsedPhonePD.text,
          "addresses": [
              {
                  "address_1": controllerShippingD.parsedAddress1SD.text,
                  "address_2": address2SD,
                  "zipcode": controllerShippingD.parsedZipcodeSD.text,
                  "city": controllerShippingD.parsedCitySD.text,
                  "state_code": "TX",
                  "type": "Physical",
                  "latitude": controllerShippingD.positionSD?.toJSON()?.lat,
                  "longitude": controllerShippingD.positionSD?.toJSON()?.lng
              },
              {
                  "address_1": controllerShippingD.parsedAddress1SD.text,
                  "address_2": address2SD,
                  "zipcode": controllerShippingD.parsedZipcodeSD.text,
                  "city": controllerShippingD.parsedCitySD.text,
                  "state_code": "TX",
                  "type": "Billing",
                  "latitude": controllerShippingD.positionSD?.toJSON()?.lat,
                  "longitude": controllerShippingD.positionSD?.toJSON()?.lng
              }
          ],
          "services": [
              {
                  "service_id": 1
              }
          ],
          "credit_card": {
              "card_number": controllerPaymentD.number.text.replaceAll(" ", "").toString(),
              "exp_month": controllerPaymentD.date.text.split("/")[0],
              "exp_year": controllerPaymentD.date.text.split("/")[1],
              "cvv": controllerPaymentD.cvv.text
          },
          "amount": int.parse((total.round()*100).toString())
        };
      } else {
        final address2SD = (controllerShippingD.parsedAddress2SD.text == "" || 
        controllerShippingD.parsedAddress2SD.text.isEmpty) ?
        null
        :
        controllerShippingD.parsedAddress2SD.text;
        final address2BD = (controllerPaymentD.parsedAddress2BD.text == "" || 
        controllerPaymentD.parsedAddress2BD.text.isEmpty) ?
        null
        :
        controllerPaymentD.parsedAddress2BD.text;
        jsonAPI = {
          "first_name": controllerPesonalD.parsedFNamePD.text,
          "last_name": controllerPesonalD.parsedLNamePD.text,
          "email": controllerPesonalD.parsedEmailPD.text,
          "mobile_phone": controllerPesonalD.parsedPhonePD.text,
          "addresses": [
              {
                  "address_1": controllerShippingD.parsedAddress1SD.text,
                  "address_2": address2SD,
                  "zipcode": controllerShippingD.parsedZipcodeSD.text,
                  "city": controllerShippingD.parsedCitySD.text,
                  "state_code": "TX",
                  "type": "Physical",
                  "latitude": controllerShippingD.positionSD?.toJSON()?.lat,
                  "longitude": controllerShippingD.positionSD?.toJSON()?.lng
              },
              {
                  "address_1": controllerPaymentD.parsedAddress1BD.text,
                  "address_2": address2BD,
                  "zipcode": controllerPaymentD.parsedZipcodeBD.text,
                  "city": controllerPaymentD.parsedCityBD.text,
                  "state_code": "TX",
                  "type": "Billing",
                  "latitude": controllerPaymentD.positionBD?.toJSON()?.lat,
                  "longitude": controllerPaymentD.positionBD?.toJSON()?.lng
              }
          ],
          "services": [
              {
                  "service_id": 1
              }
          ],
          "credit_card": {
              "card_number": controllerPaymentD.number.text.replaceAll(" ", "").toString(),
              "exp_month": controllerPaymentD.date.text.split("/")[0],
              "exp_year": controllerPaymentD.date.text.split("/")[1],
              "cvv": controllerPaymentD.cvv.text
          },
          "amount": int.parse((total.round()*100).toString())
        };
      }
      var urlAPI = Uri.parse("${urlAirflow}customer");
      var responseAPI = await post(urlAPI,
        headers: headers,
        body: json.encode(jsonAPI),
        );
      if (!responseAPI.body.contains("Error")) {
        if(!context.mounted) return;
        //Se realiza éxitosamente el proceso en Airflow
        showDialog(
          barrierColor: const Color(0x00022963).withOpacity(0.40),
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return const FinalPopupSuccess();
          },
        );
      } else {
        if(!context.mounted) return;
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
      if(!context.mounted) return;
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