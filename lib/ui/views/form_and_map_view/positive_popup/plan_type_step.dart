import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rolling_switch/rolling_switch.dart';
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
          'Click "Start now" \n to continue',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 30 : 50,
            height: 1.5,
            color: colorInversePrimary,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        // const SizedBox(height: 20),
        // Consumer<PopupController>(builder: (_, controller, ___) {
        //   return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           height: mobile ? 230 : 270,
        //           width: mobile ? 215 : 450,
        //           child: FittedBox(
        //             fit: BoxFit.contain,
        //             child: RollingSwitch.widget(
        //                 key: ValueKey(controller.planSwitch),
        //                 initialState: false,
        //                 onChanged: (bool state) {
        //                   controller.planSwitch = state;
        //                   controller.setPlan();
        //                 },
        //                 rollingInfoLeft: RollingWidgetInfo(
        //                   icon: const Icon(
        //                     Icons.house_outlined,
        //                     color: colorSecondary,
        //                   ),
        //                   text: Text(
        //                     "Residential",
        //                     style: GoogleFonts.plusJakartaSans(
        //                       fontSize: 11,
        //                       color: colorInversePrimary,
        //                       fontWeight: FontWeight.w600,
        //                     ),
        //                   ),
        //                   backgroundColor: colorSecondary,
        //                 ),
        //                 rollingInfoRight: RollingWidgetInfo(
        //                   icon: const Icon(Icons.business_center_outlined,
        //                       color: colorSecondary),
        //                   backgroundColor: colorSecondary,
        //                   text: Text(
        //                     'Business',
        //                     style: GoogleFonts.plusJakartaSans(
        //                         fontSize: 16,
        //                         color: colorInversePrimary,
        //                         fontWeight: FontWeight.w600,
        //                         letterSpacing: -0.1),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         // CustomRadioButton(
        //         //     text: 'Residential',
        //         //     icon: Icons.house_outlined,
        //         //     value: Plan.residential,
        //         //     function: controller.setPlan,
        //         //     groupValue: controller.plan),
        //         // mobile ? const Spacer() : const SizedBox(width: 150),
        //         // CustomRadioButton(
        //         //     text: 'Business',
        //         //     icon: Icons.business_center_outlined,
        //         //     value: Plan.business,
        //         //     function: controller.setPlan,
        //         //     groupValue: controller.plan),
        //       ],
        //     ),
        //   );
        // }),
        const SizedBox(height: 40),
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
            fontSize: 40,
          );
        }),
        const SizedBox(height: 10),
      ],
    );
  }
}
