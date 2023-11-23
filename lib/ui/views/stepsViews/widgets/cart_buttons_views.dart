import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);

  switch (stepsController.currentStep) {
    //Se controla la leyenda del botón del shopping cart, dependiendo la vista actual del proceso.
    case Views.customerInfoView:
      //Se controla la opacidad del botón (que se haga ver habilitado)
      var opacity = stepsController.promoCheckFlag ? 1.0 : 0.50;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Save & Finish",
          function: () {
            if (stepsController.formValidation()) {
              finalPressed(context, cartController);
            }
          },
          cartContains: cartController.products.isNotEmpty);

    default:
      return const Text("");
  }
}

void finalPressed(BuildContext context,
      Cart cartController) async {
      showDialog(
        barrierColor: const Color(0x00022963).withOpacity(0.40),
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const FinalPopup();
        },
      );
  }

