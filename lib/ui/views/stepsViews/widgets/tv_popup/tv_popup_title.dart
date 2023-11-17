import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVPopupTitle extends StatelessWidget {
  final String name;
  final String featTitle;
  final String price;
  const TVPopupTitle({
    Key? key,
    required this.name,
    required this.price,
    required this.featTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Row(
      children: [
        Image.asset(
          'images/icon_gigFastTV.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: GoogleFonts.workSans(
                  fontSize: desktop ? 25 : (size.width > 880) ? 15 : 18,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
            Text(
              featTitle,
              style: GoogleFonts.workSans(
                  fontSize: desktop ? 18 : 12,
                  color: const Color(0xFFd20030),
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5),
            )
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Wrap(
          children: [
            Text(
              '\$$price',
              style: GoogleFonts.workSans(
                  fontSize: desktop ? 26 : (size.width > 880) ? 15 : 18,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0),
            ),
            Text(
              "/mo",
              style: GoogleFonts.workSans(
                  fontSize: desktop ? 16 : 8,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0),
            ),
          ],
        )
      ],
    );
  }
}
