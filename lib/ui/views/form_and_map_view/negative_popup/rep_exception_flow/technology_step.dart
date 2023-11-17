import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/popup_controller.dart';
import '../../../../buttons/custom_outlined_button.dart';
import '../../../../inputs/custom_radio_button.dart';
import '../../parse_methods.dart';

class TechnologyStep extends StatelessWidget {
  const TechnologyStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final controller = Provider.of<PopupController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'You have selected ',
              style: GoogleFonts.poppins(
                fontSize: mobile ? 13 : 18,
                height: 1,
                color: const Color(0xff001E4D),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: parseLocation(controller.customerInfo.locationGroup),
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 13 : 18,
                    height: 1,
                    color: const Color(0xffd20030),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: " as a location. \n To continue, please",
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 13 : 18,
                    height: 1,
                    color: const Color(0xff001E4D),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
        ),
        Text(
          'choose a technology:',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 20 : 30,
            height: 1.5,
            color: const Color(0xff001E4D),
            fontWeight: FontWeight.w700,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Consumer<PopupController>(builder: (_, controller, ___) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadioButton(
                    text: 'Fiber',
                    icon: Icons.cable_rounded,
                    value: Technology.fiber,
                    function: controller.setTechnology,
                    groupValue: controller.technology),
                mobile ? const Spacer() : const SizedBox(width: 150),
                CustomRadioButton(
                    text: 'Fixed Wireless',
                    icon: Icons.cell_tower_rounded,
                    value: Technology.fixedWireless,
                    function: controller.setTechnology,
                    groupValue: controller.technology),
              ],
            ),
          );
        }),
        const SizedBox(height: 30),
        Consumer<PopupController>(builder: (_, controller, ___) {
          return CustomOutlinedButton(
            onPressed: () {
              controller.customerInfo.coverageType = controller.technology.name;
              controller.changeStep();
            },
            text: 'Next',
            bgColor: const Color(0xFFD20030),
          );
        }),
      ],
    );
  }
}
