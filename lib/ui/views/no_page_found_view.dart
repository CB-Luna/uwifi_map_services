import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPageFoundView extends StatelessWidget {
  const NoPageFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404 - Page not found',
        style: GoogleFonts.montserratAlternates(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}