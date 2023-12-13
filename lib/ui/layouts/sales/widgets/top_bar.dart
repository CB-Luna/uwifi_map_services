import 'package:flutter/material.dart';
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
  }) : super(key: key);


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
