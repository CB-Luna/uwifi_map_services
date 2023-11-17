import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/layouts/map/widgets/step_widget.dart';

class CustomTitle extends StatelessWidget {
  final bool mobile;
  const CustomTitle({Key? key, this.mobile = false}) : super(key: key);

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
              image: AssetImage('/images/uwifi.png'),
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
                'Find the services \nnear your area',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 35,
                  height: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          textStepOne()
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
                child: Image(
                  image: AssetImage('/images/uwifi.png'),
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
                'Find the services \nnear your area',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 55,
                  height: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          textStepOne()
        ],
      ),
    );
  }
}

Widget textStepOne([double? bodyFontSize]) {
  return const CustomStep(icon: Icons.my_location_rounded, texts: [
    "Step 1: Find your address",
    "Enter your address or drag the icon on the map to your location."
  ]);
}
