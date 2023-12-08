// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/providers/tracking_provider.dart';
import 'package:uwifi_map_services/router/router.dart';

abstract class HomePage {
  Future<void> showPopup(
    SearchLocalController searchLocalController,
    TrackingProvider trackingController,
    Cart cartController,
    BuildContext context,
  ) async {
    final result = await searchLocalController.confirm();
    final customerInfo = searchLocalController.fillCustomerInfo();

    if (result) {
      cartController.clearAllProducts();
      if (!(customerInfo.customerRep != '')) {
        trackingController.changeViewIndex();
        trackingController.recordTrack();
      }
      Flurorouter.router.navigateTo(
        context,
        Flurorouter.salesRoute,
        routeSettings: RouteSettings(
          arguments: customerInfo,
        ),
        replace: true,
        maintainState: false,
      );
    } else {
      // showDialog(
      //   context: context,
      //   builder: (_) {
      //     return PositivePopup(
      //       customerInfo: customerInfo,
      //     );
      //   },
      // );
      cartController.clearAllProducts();
      if (!(customerInfo.customerRep != '')) {
        trackingController.changeViewIndex();
        trackingController.recordTrack();
      }
      Flurorouter.router.navigateTo(
        context,
        Flurorouter.salesRoute,
        routeSettings: RouteSettings(
          arguments: customerInfo,
        ),
        replace: true,
        maintainState: false,
      );
    }
  }
}
