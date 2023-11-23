import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';

class SliderWidget extends StatelessWidget {
  final String id;
  final double basePrice;
  final String category;
  final int index;
  final double maxValue;
  final String? productName;

  const SliderWidget({
    Key? key,
    required this.id,
    required this.basePrice,
    required this.category,
    required this.index,
    required this.maxValue,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final double thumbSize = mobile ? 8 : 10;
    final double fontSize = mobile ? 12 : 14;
    final double sliderRadius = mobile ? 15 : 25;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0",
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.2,
                ),
              ),
              Flexible(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xff2e5899),
                    inactiveTrackColor: const Color(0xff8AA7D2),
                    activeTickMarkColor: const Color(0xff2e5899),
                    inactiveTickMarkColor: const Color(0xff8AA7D2),
                    trackShape: const RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbColor: const Color(0xff2e5899),
                    thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: thumbSize),
                    overlayColor: const Color(0xff2e5899).withAlpha(50),
                    overlayShape:
                        RoundSliderOverlayShape(overlayRadius: sliderRadius),
                  ),
                  child: Text("Text"),
                ),
              ),
              Text(
                maxValue.toString(),
                style: GoogleFonts.workSans(
                  fontSize: 16,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.2,
                ),
              ),
            ],
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
                    "\$",
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
                Text("For $productName(s)",
                    style: GoogleFonts.workSans(
                      fontSize: fontSize,
                      color: const Color(0xFF2e5899),
                      fontWeight: FontWeight.w300,
                      letterSpacing: -0.5,
                    ))
              ]),
        )
      ],
    );
  }
}
