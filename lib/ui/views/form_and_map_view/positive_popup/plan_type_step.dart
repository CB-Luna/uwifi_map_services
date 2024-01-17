import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tracking_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

import '../../../../../providers/popup_controller.dart';
import '../../../../classes/customer_info.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../router/router.dart';
import '../../stepsViews/widgets/buttons/custom_outlined_button.dart';
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
    final bool mobile = size.width < 1024 ? true : false;

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
        const SizedBox(height: 40),
        Consumer<PopupController>(builder: (_, controller, ___) {
          return CustomOutlinedButton(
            onPressed: () {
              cartController.clearAllProducts();
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
