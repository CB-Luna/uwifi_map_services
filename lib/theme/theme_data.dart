import 'package:flutter/material.dart';

//Backgrounds
const colorBgLight = Color(0xFFEBF3FC);
const colorBgW = Color(0xFFF4F4F4);
const colorBgWhite = Color(0xFFFFFFFF);

const colorBgDark = Color(0xFF140D03);
const colorBgB = Color(0xFF191919);
const colorBgBlack = Color(0xFF000000);
const colorBoxShadow = Color(0x3F000000);

// const imgBg = "$strapiUrl/uploads/waves_bg_opacity_be9bc7371f.png";

//FontsR
const standFont = 'Plus Jakarta Sans';
const mainTitleFont = "Plus Jakarta Sans";
const bodyFont = "Plus Jakarta Sans";

//General Colors
const colorPrimary = Color(0xFF7949DC);
const colorPrimaryLight = Color(0xFF8A5DD8);
const colorPrimaryShade = Color(0xFF7D47DD);
const colorPrimaryDark = Color(0xFF492C7C);
const colorPrimaryContainerLight = Color(0xFFEDF6FF);
const colorPrimaryContainer = Color(0xFFDFECF9);

const colorSecondary = Color(0xFF00B837);
const colorSecondaryLight = Color(0xFF00C637);
const colorSecondaryShade = Color(0xFF00B837);

const colorTertiary = Color(0xFF13B295);
const colorTertiaryDark = Color(0xff47B489);

const colorInversePrimary = Color(0xFFFFFFFF);

//Decoration Colors
const colorBorder = Color(0xFF8D8D8D);
const colorBtnTxt = Color(0xADC39292);
const colorBtnTxtLight = Color(0xC8ECE7E7);

ThemeData defaultTheme = ThemeData(
  scrollbarTheme: const ScrollbarThemeData().copyWith(
    trackVisibility: MaterialStateProperty.all(true),
    thumbColor:
        MaterialStateProperty.all(const Color(0xFF7949DC).withOpacity(0.5)),
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
