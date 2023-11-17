import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardMovieBundleComingSoon extends StatelessWidget {
  final int index; 
  final String name;
  final String image;
  final double cost;
  const CustomCardMovieBundleComingSoon({
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
        SizedBox(
          height: 80,
          width: 100,
          child: Stack(
          children: [
              Opacity(
                opacity: 0.5,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Column(
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: comingSoonArea()),
          ]),
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
    Widget comingSoonArea() {
    final area = Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: -15,
            color: Color(0x506FA5DB),
            offset: Offset(0, 15),
          ),
        ],
        borderRadius: BorderRadius.circular(12.0),
        color: const Color.fromARGB(210, 0, 35, 88).withOpacity(0.6),
      ),
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
            size: 14.0,
          ),
          const SizedBox(width: 5),
          Text("Coming Soon",
              style: GoogleFonts.workSans(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2)),
        ],
      ),
    );
    return area;
  }
}