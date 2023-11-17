import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tracking_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

import '../../../../../providers/popup_controller.dart';
import '../../../../classes/customer_info.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../router/router.dart';
import '../../../buttons/custom_outlined_button.dart';
import '../../../inputs/custom_radio_button.dart';

class PlanTypeStep extends StatelessWidget {
  final CustomerInfo? customerInfo;

  const PlanTypeStep({
    this.customerInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    final tracking = Provider.of<TrackingProvider>(context);

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'What type of plans \n are you looking for?',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 20 : 30,
            height: 1.5,
            color: colorInversePrimary,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Consumer<PopupController>(builder: (_, controller, ___) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadioButton(
                    text: 'Residential',
                    icon: Icons.house_outlined,
                    value: Plan.residential,
                    function: controller.setPlan,
                    groupValue: controller.plan),
                mobile ? const Spacer() : const SizedBox(width: 150),
                CustomRadioButton(
                    text: 'Business',
                    icon: Icons.business_center_outlined,
                    value: Plan.business,
                    function: controller.setPlan,
                    groupValue: controller.plan),
              ],
            ),
          );
        }),
        const SizedBox(height: 30),
        Consumer<PopupController>(builder: (_, controller, ___) {
          return CustomOutlinedButton(
            onPressed: () {
              cartController.clearAllProducts();
              cartController.discounts.clear();
              controller.customerInfo.serviceType = controller.plan.name;
              Flurorouter.router.navigateTo(
                context,
                Flurorouter.salesRoute,
                routeSettings: RouteSettings(
                  arguments: controller.customerInfo,
                ),
                replace: true,
                maintainState: false,
              );

              if (customerInfo != null) {
                if (!(customerInfo!.customerRep != '')) {
                  tracking.changeViewIndex();
                  tracking.recordTrack();
                }
              }
            },
            text: 'Start now',
            bgColor: colorSecondary,
          );
        }),
        const SizedBox(height: 10),
      ],
    );
  }
}
