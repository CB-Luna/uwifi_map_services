import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardMovieBundle extends StatelessWidget {
  final int index; 
  final String name;
  final String image;
  final double cost;
  const CustomCardMovieBundle({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
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
                          style: GoogleFonts.workSans(
                            fontSize: name.length > 54 ? 7 : 8,
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
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child:Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                            color: Color(0xFFD20030),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(12)),
                          ),
                      child: 
                          const Center(
                            child: Icon(Icons.check,
                            color: Colors.white,
                            size: 15,
                            ),
                          )
                    ),
                  )
              ]),
            ),
          ),
        ),
        Container(
            height: 70,
            width: 140,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff8AA7D2)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)),
            padding: const EdgeInsets.all(7.0),
            child: Center(
              child: Container(
                height: 45,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(image),
                  ),
                ),
              ),
            ),
          ),
      ],
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