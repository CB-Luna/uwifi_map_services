import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../buttons/custom_outlined_button.dart';

class PopFinishedReferral extends StatelessWidget {
  const PopFinishedReferral({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 300,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Your referral has been added succesfully",
            style: GoogleFonts.workSans(
              fontSize: 24,
              height: 1.5,
              color: const Color(0xff436aa5),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          CustomOutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Close'),
        ],
      ),
    );
  }
}
