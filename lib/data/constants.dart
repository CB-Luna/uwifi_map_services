import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

const String apiKey = '3cBEFVR4qQleIRO2yWu0FcOCDdyZbuaU';

const String env = String.fromEnvironment(
  'env',
  defaultValue: 'https://rtadev-ecom.cbluna-dev.com',
);

const String adobeSign =
    "https://secure.na4.adobesign.com/public/esignWidget?wid=CBFCIBAA3AAABLblqZhC5f1WZ9fh54n2QZHveWX05UHgRPWOoW275lMst02hQvOWJ75nBf4nbOjzrqZmQ0uU*"; //Development

// const String adobeSign = "https://secure.na4.adobesign.com/public/esignWidget?wid=CBFCIBAA3AAABLblqZhAQ40zpZJg9vOY1JwtMdOG30knysqUug4arq5cZJn40_6O0iLxqJTxkBc_pOljWgDo*"; //Production

Color backgroundColorPortability = Colors.grey.shade200.withOpacity(0.8);

const Color iconBackgroundColorPortability = Color.fromARGB(255, 8, 43, 95);

// D I M E N S I O N S

// D e s k t o p
const double minWidth = 900.0;
const double maxWidth = 2600;
const double maxRangeValue = maxWidth - minWidth;

const double cartWidth = 300;

// F u n c i o n e s   p a r a   t a m a ñ o s   s e g ú n   e l   c o n t e x t o

////Identifica el tamaño actual de la pantalla
screenSize(context) {
  var screenSize = MediaQuery.of(context).size;
  return screenSize;
}

////Identifica si el tamaño de la pantalla es el considerado para un dispositivo móvil o no
mobile(context) {
  bool mobile = screenSize(context).width < minWidth ? true : false;

  return mobile;
}

equiv(context) {
  Size screen = screenSize(context);

  double equiv = mobile(context)
      ? 0.5
      : screen.width > maxWidth
          ? 1
          : ((screen.width - minWidth) / maxRangeValue);

  return equiv;
}

theme(context) {
  return Theme.of(context);
}

colorsTheme(context) {
  return theme(context).colorScheme;
}

double textSize = 0;

TextStyle titleStyle(context, {fontSize, color}) {
  textSize = lerpDouble(24, 50, screenSize(context).width * 0.0005)!;

  return GoogleFonts.plusJakartaSans(
    color: color ?? colorsTheme(context).primary,
    fontSize: fontSize ?? textSize,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );
}

TextStyle subtitleStyle(context, {fontSize, color}) {
  textSize = lerpDouble(24, 30, screenSize(context).width * 0.0005)!;

  return GoogleFonts.plusJakartaSans(
    color: color ?? colorInversePrimary,
    fontSize: fontSize ?? textSize,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.25,
  );
}

TextStyle h2Style(context, {fontSize, color}) {
  textSize = lerpDouble(18, 22, screenSize(context).width * 0.0005)!;

  return GoogleFonts.plusJakartaSans(
    color: color ?? colorsTheme(context).primary,
    fontSize: fontSize ?? textSize,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );
}

TextStyle tagTitleStyle(context, {fontSize, color}) {
  textSize = lerpDouble(12, 16, screenSize(context).width * 0.0005)!;

  return GoogleFonts.plusJakartaSans(
    color: color ?? colorsTheme(context).onPrimary,
    fontSize: fontSize ?? textSize,
    fontWeight: FontWeight.w600,
  );
}

TextStyle bodyStyle(context, {fontSize, color}) {
  textSize = lerpDouble(12, 18, screenSize(context).width * 0.00035)!;

  return GoogleFonts.plusJakartaSans(
    height: 1.5,
    letterSpacing: 0.15,
    color: color ?? colorsTheme(context).primary,
    fontSize: fontSize ?? textSize,
  );
}
