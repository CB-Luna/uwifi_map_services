import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareImageCommingSoon extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final String image;
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final bool isNetworkImage;
  const SquareImageCommingSoon({
    Key? key,
    required this.size,
    required this.image,
    this.color = Colors.white,
    this.borderColor = const Color(0xffD8E3F2),
    this.text,
    this.fontSize = 10.5,
    this.textColor = const Color(0xff2E5899),
    this.isNetworkImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeMedia = MediaQuery.of(context).size;
    final bool desktop = sizeMedia.width > 1350 ? true : false;
    var container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Colors.white),
        image: DecorationImage(
          alignment: Alignment.center,
          image: getImage(isNetworkImage, image),
          fit: BoxFit.scaleDown,
        ),
      ),
      child: comingSoonArea(desktop),
    );
    return text != null
        ? SizedBox(
            width: 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                container,
                const SizedBox(
                  height: 5,
                ),
                Text(
                  desktop ? text! : 'Coming Soon',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.workSans(
                    fontSize: desktop ? fontSize : 8,
                    height: 1,
                    color: const Color(0xff8AA7D2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : container;
  }

  ImageProvider getImage(bool isNetworkImage, String image) {
    if (isNetworkImage) {
      return NetworkImage(image);
    } else {
      return AssetImage(image);
    }
  }

  Widget comingSoonArea(bool desktop) {
    final area = Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: -15,
            color: Color(0x506FA5DB),
            offset: Offset(0, 15),
          )
        ],
        color: const Color.fromARGB(210, 0, 35, 88).withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(4),
      child: desktop
          ? Column(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Colors.white,
                  size: 18.0,
                ),
                const SizedBox(height: 5),
                Text("Coming Soon",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2)),
              ],
            )
          : const Icon(
              Icons.error_outline_rounded,
              color: Colors.white,
              size: 16.0,
            ),
    );
    return area;
  }
}
