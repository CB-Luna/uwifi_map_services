import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uwifi_map_services/providers/mobile_cart_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/buttons/custom_icon_button.dart';
import 'package:badges/badges.dart' as badge;

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
    final mobileCartProvider = Provider.of<MobileCartProvider>(context);
    final stepsController = Provider.of<StepsController>(context);
    final cartController = Provider.of<Cart>(context);

    final tracking = Provider.of<track.TrackingProvider>(context);

    // FUNCIÓN PARA DEVOLVER AL STATUS INICIAL LO RELACIONADO A LAS SALES
    setDefault() {
      tracking.setView = track.Views.map;
      cartController.clearAllProducts();
    }

    bool onelineDisplay = screenSize(context).width >= 1100;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;

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
              'https://uwif-astro-web.vercel.app/'), 
              webOnlyWindowName: '_self',);
            },
          ),
          const Spacer(),
          StepperWidget(
            width: 140,
            curStep: stepsController.currentStep.index,
            activeColor: colorPrimary),
          const Spacer(),
          Visibility(
            visible: isMobile,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClayContainer(
                spread: 6,
                color: colorPrimary,
                parentColor: colorInversePrimary,
                height: 45,
                width: 45,
                depth: 40,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: InkWell(
                  onTap: () {
                    mobileCartProvider.changeBodyOption();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: mobileCartProvider.valueBodyOption == 0 ?
                    badge.Badge(
                      badgeContent: Text(
                          cartController.generalCartCounter.toString(),
                          style: const TextStyle(color: colorInversePrimary)),
                      showBadge:
                          cartController.generalCartCounter == 0 ? false : true,
                      badgeColor: colorSecondary,
                      position: badge.BadgePosition.bottomStart(),
                      elevation: 4,
                      child: const Icon(
                        Icons.add_shopping_cart_outlined,
                        color: colorInversePrimary,
                        size: 25,
                      ),
                    )
                    :
                    const Icon(
                      Icons.view_list_outlined,
                      color: colorInversePrimary,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
