import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';

class TVPopupTitleMobile extends StatelessWidget {
  final String name;
  final String featTitle;
  final String price;
  const TVPopupTitleMobile({
    Key? key,
    required this.name,
    required this.price,
    required this.featTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TVPopupController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(
              'images/icon_gigFastTV.png',
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.workSans(
                      fontSize: 22,
                      color: const Color(0xFF2e5899),
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5),
                ),
                Text(
                  featTitle,
                  style: GoogleFonts.workSans(
                      fontSize: 18,
                      color: const Color(0xFFd20030),
                      fontWeight: FontWeight.w300,
                      letterSpacing: -0.5),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '\$$price',
              style: GoogleFonts.workSans(
                  fontSize: 22,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0),
            ),
            Text(
              "/mo",
              style: GoogleFonts.workSans(
                  fontSize: 16,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0),
            ),
            const SizedBox(
              width: 50,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE77690),
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              onPressed: () => controller.changeView(1),
              child: const Text('See more channels'),
            )
          ],
        ),
      ],
    );
  }
}
