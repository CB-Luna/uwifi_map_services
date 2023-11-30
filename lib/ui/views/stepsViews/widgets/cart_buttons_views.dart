import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

styledButton(context) {
  final cartController = Provider.of<Cart>(context);
  final stepsController = Provider.of<StepsController>(context);
  final controllerCustomer = Provider.of<CustomerShippingInfo>(context);

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
        //  final recordCustomer = await supabase.from('customer').insert(
        //   {
        //     'first_name': controllerCustomer.firstName,
        //     'last_name': controllerCustomer.lastName,
        //     'email': controllerCustomer.custEmail,
        //     'mobile_phone': controllerCustomer.phone,
        //   },
        // ).select<PostgrestList>('customer_id');
        // final recordAddresBilling = await supabase.from('address').insert(
        //   {
        //     'address_1': "123 1st St.",
        //     'address_2': Null,
        //     'zipcode': "12345",
        //     'city': "Los Angeles",
        //     'state_fk': 6,
        //     'country': "US",
        //     'type': "Billing",
        //     'customer_fk': recordCustomer.first['customer_id'],
        //   },
        // ).select<PostgrestList>('address_id');
        // final recordAddresPhysical = await supabase.from('address').insert(
        //   {
        //     'address_1': "123 1st St.",
        //     'address_2': Null,
        //     'zipcode': "12345",
        //     'city': "Los Angeles",
        //     'state_fk': 6,
        //     'country': "US",
        //     'type': "Physical",
        //     'customer_fk': recordCustomer.first['customer_id'],
        //   },
        // ).select<PostgrestList>('address_id');

        // if (recordCustomer.isNotEmpty && recordAddresBilling.isNotEmpty && recordAddresPhysical.isNotEmpty) {
        //   // ignore: use_build_context_synchronously
          showDialog(
            barrierColor: const Color(0x00022963).withOpacity(0.40),
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return const FinalPopup();
            },
          );
        // } 
  }