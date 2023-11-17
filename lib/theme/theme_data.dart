import 'package:flutter/material.dart';

//Backgrounds
const colorBgLight = Color(0xffebf3fc);
const colorBg = Color(0xffd8e4f4);
const colorBgWhite = Color(0xffffffff);
// const imgBg = "$strapiUrl/uploads/waves_bg_opacity_be9bc7371f.png";

//FontsR
const standFont = 'Plus Jakarta Sans';
const mainTitleFont = "Plus Jakarta Sans";
const bodyFont = "Plus Jakarta Sans";

//General Colors
const colorPrimary = Color(0xFF2e5899);
const colorPrimaryLight = Color(0xFF1A65D4);
const colorPrimaryShade = Color(0xff22457B);
const colorPrimaryDark = Color(0xFF092146);
const colorPrimaryContainerLight = Color(0xFFEDF6FF);
const colorPrimaryContainer = Color(0xFFDFECF9);

const colorSecondary = Color(0xFFd20030);
const colorSecondaryLight = Color(0xffF84971);
const colorSecondaryShade = Color(0xff9d0020);

const colorTertiary = Color(0xFF13B295);
const colorTertiaryDark = Color(0xff47B489);

const colorInversePrimary = Color(0xFF7391BE);

//Button Decoration Colors
const colorBtnBorder = Color.fromRGBO(255, 255, 255, 0.459);
const colorBtnTxt = Color(0xADC39292);
const colorBtnTxtLight = Color(0xC8ECE7E7);

ThemeData defaultTheme = ThemeData(
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    trackVisibility: MaterialStateProperty.all(true),
    thumbColor:
        MaterialStateProperty.all(const Color(0xff2e5899).withOpacity(0.5)),
    mainAxisMargin: 2.5,
    crossAxisMargin: 2.5,
    trackColor: MaterialStateProperty.all(colorPrimaryShade.withOpacity(0.25)),
  ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: colorPrimary,
    onPrimary: colorPrimaryDark,
    secondary: colorSecondary,
    onSecondary: colorSecondaryLight,
    tertiary: colorTertiary,
    onTertiary: colorTertiaryDark,
    inversePrimary: colorInversePrimary,
    background: Colors.white,
    onBackground: Colors.white,
    surface: colorPrimaryDark,
    onSurface: colorPrimaryLight,
    error: Color(0xFFDB004D),
    onError: Color(0xA1DB004D),
  ),

  /////
);
