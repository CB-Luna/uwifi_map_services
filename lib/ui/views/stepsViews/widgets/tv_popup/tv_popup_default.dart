import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/popup.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/tv_popup_dafault_desktop.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/tv_popup_dafault_tablet.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/tv_popup_default_mobile_neumorphic.dart';

class TVDefault extends StatelessWidget with Popup {
  final Plan plan;
  const TVDefault({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final tvPopupController = Provider.of<TVPopupController>(context);
    final cartController = Provider.of<Cart>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cartController.fees.isEmpty) {
        cartController.addFeesToCart(tvPopupController.fees);
      } else {
        for (var i = 0; i < tvPopupController.fees.length; i++) {
          List<Product> contains = cartController.fees
              .where(
                  (item) => item.category == tvPopupController.fees[i].category)
              .toList();

          if (contains.isEmpty) {
            cartController.addFeesToCart(tvPopupController.fees);
          }
        }
      }
      if (cartController.packsPremium.isEmpty) {
        for (var i = 0;
            i < tvPopupController.packagePremiumChannels.length;
            i++) {
          tvPopupController.packagePremiumChannels[i].isSelected = false;
        }
        cartController
            .addPacksPremiumChannels(tvPopupController.packagePremiumChannels);
      }
    });

    if (size.width >= 1350) {
      return TVDefaultDesktop(plan: plan);
    } else if (size.width > 880) {
      return TVDefaultTablet(plan: plan);
    } else {
      return TVDefaultMobileNeumorphic(plan: plan);
    }
  }
}
