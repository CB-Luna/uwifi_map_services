import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/buttons/custom_outlined_button.dart';

class ThirdStep extends StatelessWidget {
  const ThirdStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        Text(
          'Thank You!',
          style: GoogleFonts.poppins(
            fontSize: 34,
            height: 1.5,
            color: const Color(0xff2E5899),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'We\'ll get in contact with you soon.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              height: 1.5,
              color: const Color(0xff2E5899),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
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
