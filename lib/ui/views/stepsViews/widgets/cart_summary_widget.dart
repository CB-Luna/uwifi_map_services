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
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * (isMobile ? 0.9 : 0.5),
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
    );
  }
}