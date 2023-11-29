import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardAdditionalVideo extends StatelessWidget {
  final int index; 
  final String name;
  final double cost;
  const CustomCardAdditionalVideo({
    Key? key,
    required this.index,
    required this.name,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 80,
          width: 100,
          child: Stack(
          children: [
              Card(
                color: Colors.white,
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.workSans(
                        fontSize: 9,
                        height: 1,
                        color: const Color(0xff2E5899),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\$$cost/mo',
                      style: GoogleFonts.workSans(
                        fontSize: 22,
                        height: 2,
                        color: const Color(0xff2E5899),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 4,
                right: 4,
                child:
                SizedBox(
                  height: 20,
                  width: 20,
                  // decoration: BoxDecoration(
                  //       border: Border.all(color: const Color(0xFFD20030)),
                  //       borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(20),
                  //         bottomRight: Radius.circular(12)),
                  //     ),
                  child: Icon(Icons.circle_outlined,
                      color: Color(0xFF101E51),
                      size: 10,
                      )
                ),
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