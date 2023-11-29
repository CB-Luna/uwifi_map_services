import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_bundle.dart';

class CustomCardChannelComingSoonMobile extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final double cost;
  const CustomCardChannelComingSoonMobile({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 150,
      child: Stack(children: [
        Opacity(
          opacity: 0.5,
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TVPopupBundle(image: image, size: 65),
                  const SizedBox(width: 2),
                  Text(
                    '\$$cost',
                    style: GoogleFonts.workSans(
                      fontSize: 22,
                      height: 2,
                      color: const Color(0xff2E5899),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "/mo",
                    style: GoogleFonts.workSans(
                      fontSize: 10,
                      color: const Color(0xFF2e5899),
                      fontWeight: FontWeight.w300,
                      letterSpacing: -1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: comingSoonArea()),
      ]),
    );
  }


  Widget comingSoonArea() {
  final area = Container(
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          blurRadius: 15,
          spreadRadius: -15,
          color: Color(0x506FA5DB),
          offset: Offset(0, 15),
        )
      ],
      color: const Color.fromARGB(210, 0, 35, 88),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(4),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline_rounded,
          color: Colors.white,
          size: 18.0,
        ),
        const SizedBox(width: 5),
        Text("Coming Soon",
            style: GoogleFonts.workSans(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.2)),
      ],
    ),
  );
  return area;
}
}
