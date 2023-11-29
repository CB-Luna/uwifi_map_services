import 'package:flutter/material.dart';

class TVPopupBundle extends StatelessWidget {
  final String image;
  final bool isNetworkImage;
  final double size;
  const TVPopupBundle({
    Key? key,
    required this.image,
    required this.size,
    this.isNetworkImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: buildBoxDecoration(image),
    );
  }

  BoxDecoration buildBoxDecoration(String image) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15.0),
      image: DecorationImage(
        image: getImage(isNetworkImage, image),
      ),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xff00255F),
          Color(0xff2E5899),
          Color(0xff53A2FF),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff2E5899).withOpacity(0.5),
          blurRadius: 5,
          offset: const Offset(0, 4), // changes position of shadow
        ),
      ],
    );
  }

  ImageProvider getImage(bool isNetworkImage, String image) {
    if (isNetworkImage) {
      return NetworkImage(image);
    } else {
      return AssetImage(image);
    }
  }
}
