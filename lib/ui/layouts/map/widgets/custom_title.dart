import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/data/constants.dart';

class CustomTitle extends StatelessWidget {
  final bool mobile;
  const CustomTitle({Key? key, this.mobile = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return mobileTitle(context);
    } else {
      return desktopTitle(context);
    }
  }

  Widget mobileTitle(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 200,
              maxHeight: 200,
            ),
            child: const Image(
              fit: BoxFit.contain,
              image: AssetImage('/images/uwifi.png'),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'Find the services \nnear your area',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 35,
                height: 1,
                color: colorsTheme(context).inversePrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget desktopTitle(BuildContext context) {
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
            height: 50,
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
                  color: colorsTheme(context).inversePrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

