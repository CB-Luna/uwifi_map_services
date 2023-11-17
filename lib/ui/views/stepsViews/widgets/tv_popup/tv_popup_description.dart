import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TVPopupDescription extends StatelessWidget {
  final String description;
  const TVPopupDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Text(
      description,
      style: GoogleFonts.workSans(
        height: 1.5,
        fontSize: desktop ? 13 : 10,
        color: const Color(0xFF8AA7D2),
        fontWeight: FontWeight.normal,
        letterSpacing: -0.2,
      ),
    );
  }
}
