import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../wigdets/gradient_button.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Please contact to the main office for more information: ',
          textAlign: TextAlign.center,
          style: GoogleFonts.workSans(
            fontSize: 18,
            height: 1.5,
            color: const Color(0xff436aa5),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        GradientButtonWidget(
          function: () => launchUrl(Uri.parse(("tel:8447824872"))),
          text: "844-782-4872",
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 5),
        const SizedBox(height: 10),
        CustomOutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Close',
          bgColor: const Color(0xFF2E5899),
          borderColor: const Color(0xFF2E5899),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
