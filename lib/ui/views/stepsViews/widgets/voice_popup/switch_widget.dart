import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:rolling_switch/rolling_switch.dart';

class SwitchWidget extends StatelessWidget {
  final String id;
  final String name;
  final double basePrice;
  final String category;
  final int index;
  final double maxValue;
  final String? productName;

  const SwitchWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.basePrice,
    required this.category,
    required this.index,
    required this.maxValue,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    double currentValue =
        cartController.additionalsLine[index].quantity.toDouble();
    double currentPrice = currentValue * basePrice;

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final double fontSize = mobile ? 12 : 14;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Center(
            child: RollingSwitch.widget(
              initialState: cartController.aciveToogle,
              width: 150,
              onChanged: (bool state) {
                // print('turned ${(state) ? 'on' : 'off'}');
                cartController.aciveToogle = !cartController.aciveToogle;
                cartController.changeSwitchAdditionalLine(index, state);
              },
              rollingInfoLeft: RollingWidgetInfo(
                icon: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xff2e5899),
                ),
                text: Text(name,
                    style: GoogleFonts.workSans(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2)),
                backgroundColor: const Color(0xff2e5899),
              ),
              rollingInfoRight: RollingWidgetInfo(
                icon: const Icon(Icons.check_circle_outline,
                    color: Color(0xFFd20030)),
                backgroundColor: const Color(0xFFd20030),
                text: Text('Added',
                    style: GoogleFonts.workSans(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "\$$currentPrice",
                    style: GoogleFonts.workSans(
                      fontSize: 26,
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
                  )
                ]),
              ]),
        )
      ],
    );
  }
}
