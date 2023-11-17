import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareImage extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final String image;
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final bool isNetworkImage;
  final bool? isAvailable;
  final String? description;
  const SquareImage({
    Key? key,
    required this.size,
    required this.image,
    this.color = Colors.white,
    this.borderColor = const Color(0xffD8E3F2),
    this.text,
    this.fontSize = 10.5,
    this.textColor = const Color(0xff2E5899),
    this.isNetworkImage = true,
    this.isAvailable = true,
    this.description = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeMedia = MediaQuery.of(context).size;
    final bool desktop = sizeMedia.width > 1350 ? true : false;
    var container = Tooltip(
        message: isAvailable! ? "" : description,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            border: Border.all(
                color: isAvailable!
                    ? borderColor
                    : const Color(0xff8AA7D2).withOpacity(0.10)),
            image: DecorationImage(
              colorFilter: isAvailable!
                  ? null
                  : ColorFilter.mode(
                      Colors.white.withOpacity(0.75), BlendMode.lighten),
              alignment: Alignment.center,
              image: getImage(isNetworkImage, image),
              fit: BoxFit.scaleDown,
            ),
          ),
        ));
    return text != null
        ? SizedBox(
            width: 75,
            child: Column(
              children: [
                container,
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.workSans(
                    fontSize: desktop ? fontSize : 8,
                    height: 1,
                    color: isAvailable! ? textColor : const Color(0xff8AA7D2),
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
}
