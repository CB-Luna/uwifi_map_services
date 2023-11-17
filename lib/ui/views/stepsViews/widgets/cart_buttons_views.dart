import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tracking_provider.dart' as track;
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final tracking = Provider.of<track.TrackingProvider>(context);
  final stepsController = Provider.of<StepsController>(context);

  switch (stepsController.currentStep) {
    case Views.plansView:
      var opacity = cartController.products.isNotEmpty ? 1.0 : 0.50;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Your Information",
          cartContains: cartController.products.isNotEmpty);

    case Views.customerInfoView:
      var opacity = stepsController.promoCheckFlag ? 1.0 : 0.50;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Order",
          function: () {
            (tracking.origin.contains("social") &&
                    stepsController.formValidation())
                ? js.context.callMethod('fbq', ['track', 'AddToCart'])
                // js.context['console'].callMethod('log',
                //     ['Evento de Facebook Pixel AddToCart ejecutado por JS'])
                : null;
          },
          cartContains: cartController.products.isNotEmpty);

    case Views.finalSummaryView:
      return CartButtons(
          opacity: 1,
          isVisible: false,
          buttonText: "",
          cartContains: cartController.products.isNotEmpty);

    default:
      return const Text("");
  }
}

styledRepButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);

  switch (stepsController.repCurrentStep) {
    case RepViews.plansView:
      return CartButtons(
          opacity: 1.0,
          isVisible: true,
          buttonText: "Order",
          cartContains: cartController.products.isNotEmpty);

    case RepViews.customerInfoView:
      var opacity = stepsController.promoCheckFlag ? 1.0 : 0.50;

      return CartButtons(
          opacity: opacity,
          isVisible: true,
          buttonText: "Choose plans",
          cartContains: cartController.products.isNotEmpty);

    case RepViews.finalSummaryView:
      return CartButtons(
          opacity: 1,
          isVisible: false,
          buttonText: "",
          cartContains: cartController.products.isNotEmpty);

    default:
      return const Text("a");
  }
}
