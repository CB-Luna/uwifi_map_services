import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

import '../parse_methods.dart';
import 'plan_type_step.dart';

class PositivePopup extends StatelessWidget with Popup {
  final CustomerInfo customerInfo;
  const PositivePopup({Key? key, required this.customerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;

    return PointerInterceptor(
      child: AlertDialog(
        alignment: const Alignment(0, 0.25),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(0),
        content: ChangeNotifierProvider<PopupController>(
          create: (_) => PopupController(customerInfo: customerInfo),
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: getConstraints(
              context: context,
              height: 550,
              width: 660,
            ),
            decoration: buildBoxDecoration(image: 'images/bg_gradient.png', fit: BoxFit.cover),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashRadius: 15.0,
                    padding: const EdgeInsets.only(right: 10),
                    icon: const Icon(
                      Icons.close,
                      color: colorInversePrimary,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Service is Available!',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 30 : 40,
                    height: 1,
                    color: colorInversePrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                PlanTypeStep(customerInfo: customerInfo)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
