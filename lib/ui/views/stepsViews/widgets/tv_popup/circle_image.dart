import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final String image;
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final bool isNetworkImage;
  final bool isRecommended;
  const CircleImage(
      {Key? key,
      required this.size,
      required this.image,
      this.color = Colors.white,
      this.borderColor = const Color(0xffD8E3F2),
      this.text,
      this.fontSize = 12,
      this.textColor = const Color(0xff8AA7D2),
      this.isNetworkImage = true,
      this.isRecommended = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = Stack(alignment: const Alignment(1, -1), children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          boxShadow: isRecommended
              ? [
                  const BoxShadow(
                    blurRadius: 15,
                    spreadRadius: -15,
                    color: Color(0x506FA5DB),
                    offset: Offset(0, 15),
                  )
                ]
              : [],
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
              color: isRecommended ? const Color(0xffe49253) : borderColor,
              width: isRecommended ? 2 : 1),
          image: DecorationImage(
            alignment: Alignment.center,
            image: getImage(isNetworkImage, image),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      Visibility(
          visible: isRecommended,
          child: Tooltip(
              decoration: BoxDecoration(
                color: const Color(0xff2e5899),
                borderRadius: BorderRadius.circular(25),
              ),
              textStyle: const TextStyle(
                  fontFamily: 'Work Sans', fontSize: 10, color: Colors.white),
              message: 'Recommended',
              child: Container(
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xffe49253),
                      Color(0xfff6af7c),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.star, size: 10, color: Colors.white),
                ),
              )))
    ]);
    return text != null
        ? Column(
            children: [
              container,
              const SizedBox(
                height: 5,
              ),
              Text(
                text!,
                style: GoogleFonts.workSans(
                  fontSize: fontSize,
                  height: 1,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
}
