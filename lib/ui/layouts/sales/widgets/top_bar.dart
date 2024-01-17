import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/buttons/custom_icon_button.dart';

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
          color: colorBgWhite,
          offset: Offset(0, 5),
        )
      ], color: colorBgW),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: onelineDisplay ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButton(
            icon: Icons.arrow_back_ios_rounded,
            text: "Back",
            onPressed: () async {
              // Open URL in the actual tab
              launchUrl(Uri.parse(
              'https://react--uwifi.netlify.app/'), 
              webOnlyWindowName: '_self',);
            },
          ),
          const Spacer(),
          StepperWidget(
            width: 140,
            curStep: stepsController.currentStep.index,
            activeColor: colorPrimary),
          const Spacer()
        ],
      ),
    );
  }
}
