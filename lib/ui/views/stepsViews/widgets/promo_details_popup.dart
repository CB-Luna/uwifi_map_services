import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../classes/popup.dart';
import '../../../buttons/custom_outlined_button.dart';

class PromoDetailsPopup extends StatelessWidget with Popup {
  final String promoName;
  final String? promoDescription;

  const PromoDetailsPopup(
      {Key? key, required this.promoName, this.promoDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final size = MediaQuery.of(context).size;

    const double minWidth = 900.0;
    const double maxRangeValue = 1300.0;
    final double equiv =
        (size.width < minWidth ? 0 : (size.width - minWidth)) / maxRangeValue;

    double? titleFontSize = lerpDouble(25, 35, equiv);

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      content: Container(
        padding: const EdgeInsets.all(25),
        constraints:
            const BoxConstraints(maxWidth: 850, minWidth: 700, maxHeight: 650),
        decoration: buildBoxDecoration(
            image: 'images/bg_gradient.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(promoName,
                  style: GoogleFonts.getFont('Poppins',
                      color: const Color(0xFF2E5899),
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize)),
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    controller: scrollController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: Image.network(
                              promoDescription!,
                              width: 800,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: CustomOutlinedButton(
                    text: 'Ok',
                    borderColor: const Color(0xFF2E5899),
                    bgColor: const Color(0xFF2E5899),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )
            ]),
      ),
    );
  }
}
