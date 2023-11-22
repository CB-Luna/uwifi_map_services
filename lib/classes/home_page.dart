// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/negative_popup/negative_popup.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/positive_popup/positive_popup.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/eas_popup/eas_popup.dart';

import '../ui/views/form_and_map_view/smi_popup/smi_popup.dart';

abstract class HomePage {
  Future<void> showPopup(
    SearchLocalController controller,
    BuildContext context,
  ) async {
    final result = await controller.confirm();
    final customerInfo = controller.fillCustomerInfo();

    if (result) {
      // if (controller.flow == '3') {
      //   showDialog(
      //     context: context,
      //     builder: (_) {
      //       return EasPopup(
      //         customerInfo: customerInfo,
      //       );
      //     },
      //   );
      // } else if (controller.flow == '2') {
      //   showDialog(
      //     context: context,
      //     builder: (_) {
      //       return SmiPopup(
      //         customerInfo: customerInfo,
      //       );
      //     },
      //   );
      // } else if (controller.flow == '1' || controller.flow == '') {
        showDialog(
          context: context,
          builder: (_) {
            return PositivePopup(
              customerInfo: customerInfo,
            );
          },
        );
      // }
    } else {
      showDialog(
        context: context,
        builder: (_) {
          return PositivePopup(
            customerInfo: customerInfo,
          );
        },
      );
    }
  }
}
