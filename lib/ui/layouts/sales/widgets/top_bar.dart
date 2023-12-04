import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

import '../../../../data/constants.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'package:uwifi_map_services/providers/tracking_provider.dart' as track;

import '../../../views/stepsViews/widgets/custom_stepper.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.custAddress,
  }) : super(key: key);

  final String custAddress;

  @override
  Widget build(BuildContext context) {
    //DEFINICIÓN DE PROVIDERS
    final stepsController = Provider.of<StepsController>(context);
    final cartController = Provider.of<Cart>(context);

    final tracking = Provider.of<track.TrackingProvider>(context);

    // FUNCIÓN PARA DEVOLVER AL STATUS INICIAL LO RELACIONADO A LAS SALES
    setDefault() {
      tracking.setView = track.Views.map;
      cartController.clearAllProducts();
    }

    bool onelineDisplay = screenSize(context).width >= 1100;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 15,
          spreadRadius: -5,
          color: colorBgB,
          offset: Offset(0, 5),
        )
      ], color: colorBgBlack),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: onelineDisplay ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(
                color: colorBgWhite,
                width: 2.0,
              ),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              iconSize: 18,
              color: colorBgWhite,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                setDefault();
              },
            ),
          ),
          const Spacer(),
          StepperWidget(
            width: 50,
            curStep: stepsController.currentStep.index,
            activeColor: colorsTheme(context).primary),
          const Spacer()
        ],
      ),
    );
  }
}
