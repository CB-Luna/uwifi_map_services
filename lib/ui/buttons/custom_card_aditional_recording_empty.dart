import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardAdditionalRecordingEmpty extends StatelessWidget {
  const CustomCardAdditionalRecordingEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 100,
      child: Stack(
      children: [
          Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                      color: Color(0xFFD20030),
                      width: 1.5,
                    ),
              borderRadius: BorderRadius.circular(12.0)
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Not Additional Available",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    fontSize: 12,
                    height: 1,
                    color: const Color(0xff2E5899),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
      ]),
    );
  }

}