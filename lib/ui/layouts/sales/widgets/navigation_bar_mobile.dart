import 'package:flutter/material.dart';

import '../../../../providers/customer_info_controller.dart';
import '../../../views/stepsViews/widgets/cart_buttons_views.dart';

class NavigationMobile extends StatelessWidget {
  const NavigationMobile({
    Key? key,
    required this.customerController,
  }) : super(key: key);

  final CustomerInfoProvider customerController;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: -5,
              color: Color(0x506FA5DB),
              offset: Offset(0, -15),
            )
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        child: styledButton(context));
  }
}
