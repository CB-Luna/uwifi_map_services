import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/data/constants.dart';

class CustomStep extends StatelessWidget {
  final List<String> texts;
  final double? fontSize;
  final IconData? icon;
  const CustomStep({Key? key, required this.texts, this.fontSize, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textPrimary = GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        color: colorsTheme(context).inversePrimary,
        fontSize: fontSize ?? 18);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: colorsTheme(context).primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon,
                        size: 16, color: colorsTheme(context).inversePrimary),
                  ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var text in texts)
                        Text(
                          text,
                          style: texts.indexOf(text) > 0
                              ? bodyStyle(context)
                              : textPrimary,
                          textAlign: TextAlign.justify,
                        )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
