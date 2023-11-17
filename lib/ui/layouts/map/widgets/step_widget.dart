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
    const Color primaryColor = Colors.white;

    TextStyle textPrimary = GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        color: primaryColor,
        fontSize: fontSize ?? 18);

    var palette = colorsTheme(context);

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
                      color: palette.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon,
                        size: 16, color: Colors.white.withOpacity(0.75)),
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

  Widget stepWidget(String number, List<String> texts, [double? fontSize]) {
    const Color primaryColor = Color(0xFF2e5899);
    const Color labelColor = Color.fromARGB(255, 103, 139, 192);

    TextStyle textPrimary = GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        color: primaryColor,
        fontSize: fontSize ?? 18);

    TextStyle textLabel = GoogleFonts.plusJakartaSans(color: labelColor);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(number, style: const TextStyle(color: Colors.white))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var text in texts)
                  Text(
                    text,
                    style: texts.indexOf(text) > 0 ? textLabel : textPrimary,
                    textAlign: TextAlign.justify,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
