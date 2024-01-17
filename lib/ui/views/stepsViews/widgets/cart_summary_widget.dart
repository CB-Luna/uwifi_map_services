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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: const Column(
            children: [
              ExtrasSection(),
              HeaderCartSectionWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: CartWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}