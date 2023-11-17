import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rolling_switch/rolling_switch.dart';
import '../../../../classes/plan.dart';
import '../../../../classes/product.dart';
import '../../../../providers/cart_controller.dart';

class BundleSwitchWidget extends StatelessWidget {
  final Products product;
  final bool selected;

  const BundleSwitchWidget(
      {Key? key, required this.product, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context, listen: false);

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final double fontSize = mobile ? 10 : 12;

    final cartProduct = Product(
      id: product.id!,
      name: product.name!,
      cost: double.parse(product.price!),
      service: product.family!,
      category: product.name!,
      quantity: 1,
      pwName: product.pwName!,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Tooltip(
              verticalOffset: -22.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(168, 17, 44, 85),
                borderRadius: BorderRadius.circular(25),
              ),
              textStyle: const TextStyle(
                  fontFamily: 'Work Sans', fontSize: 10, color: Colors.white),
              message: product.description,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cartProduct.name.contains('Bundle')
                        ? cartProduct.name.replaceAll('Bundle & Save ', '')
                        : cartProduct.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      color: const Color(0xFF2E5899),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.info_outline_rounded,
                      color: const Color(0xFF2E5899).withOpacity(0.5), size: 14)
                ],
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 100, minWidth: 80),
              child: FittedBox(
                fit: BoxFit.contain,
                child: RollingSwitch.widget(
                  key: ValueKey(selected),
                  initialState: false,
                  onChanged: (bool state) {
                    state == true
                        ? cartController.addAdditionalToCart(cartProduct)
                        : cartController
                            .removeFromAdditionalCart(cartProduct.id);
                  },
                  rollingInfoLeft: RollingWidgetInfo(
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xffd20030),
                    ),
                    text: Text(
                      "Select",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: const Color(0xffd20030),
                  ),
                  rollingInfoRight: RollingWidgetInfo(
                    icon: const Icon(Icons.check_circle_outline,
                        color: Color(0xff47B489)),
                    backgroundColor: const Color(0xff47B489),
                    text: Text(
                      'Selected',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${cartProduct.cost}",
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    color: const Color(0xFF2e5899),
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.0,
                  ),
                ),
                Text(
                  "/mo",
                  style: GoogleFonts.workSans(
                    fontSize: fontSize,
                    color: const Color(0xFF2e5899),
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
