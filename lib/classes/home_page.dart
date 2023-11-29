// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/positive_popup/positive_popup.dart';

abstract class HomePage {
  Future<void> showPopup(
    SearchLocalController controller,
    BuildContext context,
  ) async {
    final result = await controller.confirm();
    final customerInfo = controller.fillCustomerInfo();

    if (result) {
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
