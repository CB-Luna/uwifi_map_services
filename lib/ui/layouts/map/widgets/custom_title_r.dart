import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitleR extends StatelessWidget {
  final bool mobile;
  const CustomTitleR({Key? key, this.mobile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return mobileTitle();
    } else {
      return desktopTitle();
    }
  }

  Widget mobileTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 50,
              maxHeight: 50,
            ),
            child: const Image(
              fit: BoxFit.contain,
              image: AssetImage('/images/referral.png'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.contain,
              child: Text(
                'Referral information',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  height: 1,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget desktopTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image(
                    image: AssetImage('/images/referral.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.contain,
              child: Text(
                'Referral information\n',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  fontSize: 45,
                  height: 1,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
