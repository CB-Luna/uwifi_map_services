import 'package:flutter/material.dart';

abstract class Popup {
  BoxConstraints getConstraints({context, width, height}) {
    final size = MediaQuery.of(context).size;
    //550, 650
    if (size.height > height && size.width > width) {
      return BoxConstraints(minHeight: height * 0.9, minWidth: width * 0.9);
    } else {
      return const BoxConstraints();
    }
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}
