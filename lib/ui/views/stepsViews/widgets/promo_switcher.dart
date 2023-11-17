import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../classes/plan.dart';
import '../../../../providers/cart_controller.dart';
import '../../../../providers/plan_controller.dart';
import 'package:flutter_switch/flutter_switch.dart';

class PromosSwitcher extends StatelessWidget {
  final PromoGroup promoGroup;
  const PromosSwitcher({Key? key, required this.promoGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final promoController = Provider.of<PlanController>(context);
    final cartController = Provider.of<Cart>(context);

    return FlutterSwitch(
      value: promoGroup.isActive,
      activeColor: const Color(0xffd20030),
      inactiveColor: const Color(0xff2e5899).withOpacity(0.3),
      width: 60,
      height: 30,
      toggleSize: 20,
      onToggle: (value) {
        for (var promo in promoGroup.promos) {
          promoController.promoActivation(promo, value);

          cartController.cleanPromos();
          if (!promoController.isAnyPlanActive()) {
            cartController.discountRules();
          } else {
            cartController.discounts
                .removeWhere((element) => element.id == "bundleDiscount");
          }
          if (value == false) {
            cartController.removePromoFromCart(promo);
          }
        }
      },
    );
  }
}
