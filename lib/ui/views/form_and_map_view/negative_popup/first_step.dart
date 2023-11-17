import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import '../../../../classes/customer_info.dart';

class FirstStep extends StatelessWidget {
  final CustomerInfo? customerInfo;
  const FirstStep({Key? key, this.customerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final controller = Provider.of<PopupController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        mobile ? const SizedBox(height: 0) : const SizedBox(height: 40),
        Text(
          'Unfortunately,\n RTA is not currently available in your area.',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 22 : 26,
            height: 1.5,
            color: const Color(0xff17273F),
            fontWeight: FontWeight.w700,
          ),
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'However, RTA is continuing to expand across America.\nWe can inform you when our services can reach you.',
          style: GoogleFonts.poppins(
            fontSize: 18,
            height: 1.5,
            color: const Color(0xff606773),
            fontWeight: FontWeight.w700,
          ),
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
        mobile ? const SizedBox(height: 20) : const SizedBox(height: 40),
        Text(
          'Would you like us to get in contact when service is\navailable in your area?',
          style: GoogleFonts.poppins(
            fontSize: 18,
            height: 1.5,
            color: const Color(0xff2E5899),
            fontWeight: FontWeight.w700,
          ),
          maxLines: 4,
          textAlign: TextAlign.center,
        ),
        mobile ? const SizedBox(height: 20) : const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomOutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Cancel',
              bgColor: const Color(0xFFC4C4C4),
              borderColor: const Color(0xFFC4C4C4),
            ),
            const SizedBox(
              width: 40,
            ),
            CustomOutlinedButton(
              onPressed: controller.changeStep,
              text: 'Accept',
              bgColor: const Color(0xFFD20030),
            ),
          ],
        ),
        if (customerInfo != null)
          if (customerInfo!.customerRep != "")
            Wrap(direction: Axis.vertical, children: [
              const SizedBox(height: 20),
              CustomOutlinedButton(
                  onPressed: () => controller.enterExceptionFlow(),
                  text: "Continue without coverage",
                  bgColor: const Color(0xFFD20030))
            ]),
        mobile ? const SizedBox(height: 10) : const SizedBox(height: 0),
      ],
    );
  }
}
