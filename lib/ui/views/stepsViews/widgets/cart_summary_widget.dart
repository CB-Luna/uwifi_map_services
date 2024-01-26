import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/extras_section_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/header_cart_section_widget.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: const Column(
                children: [
                  HeaderCartSectionWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: CartWidget(),
                  ),
                  ExtrasSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}