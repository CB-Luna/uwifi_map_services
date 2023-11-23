import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_bundle.dart';

class CustomCardChannelAvailable extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final double cost;
  const CustomCardChannelAvailable({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return GestureDetector(
            onTap: () {
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                height: 100,
                child: Stack(children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: getDecoration(isSelected),
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
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD20030),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(12)),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            )),
                  )
                ]),
              ),
            ),
          );
  }

  RoundedRectangleBorder getDecoration(isSelected) {
    late final Color borderColor;
    if (isSelected) {
      borderColor = const Color(0xFFD20030);
    } else {
      borderColor = Colors.white;
    }
    return RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0));
  }
}
