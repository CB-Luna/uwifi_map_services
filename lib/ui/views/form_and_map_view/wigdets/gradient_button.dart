import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButtonWidget extends StatefulWidget {
  final Function function;
  final String text;
  final double? fontSize;
  final bool? hideIcon;

  const GradientButtonWidget(
      {Key? key,
      required this.function,
      required this.text,
      this.fontSize,
      this.hideIcon})
      : super(key: key);

  @override
  State<GradientButtonWidget> createState() => _GradientButtonWidgetState();
}

class _GradientButtonWidgetState extends State<GradientButtonWidget> {
  Color primaryColor = const Color(0xff47B489);
  Color secondaryColor = Colors.white;
  Color gradientColor = const Color(0xFF37BE88);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => setColors(false)),
      onExit: (_) => setState(() => setColors(true)),
      child: GestureDetector(
        onTap: () async {
          widget.function();
          // await launchUrl(Uri.parse(("tel:5123604273")));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gradientColor,
                  primaryColor,
                ]),
            // border: Border.all(
            //   color: const Color.fromARGB(150, 255, 255, 255),
            //   width: 5.0,
            // ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.hideIcon == null)
                Icon(Icons.phone, color: secondaryColor, size: 16),
              const SizedBox(width: 5),
              Text(
                widget.text,
                style: GoogleFonts.workSans(
                  fontSize: widget.fontSize ?? 18,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setColors(bool isPrimary) {
    if (isPrimary) {
      primaryColor = const Color(0xff47B489);
      secondaryColor = Colors.white;
      gradientColor = const Color(0xFF37BE88);
    } else {
      primaryColor = const Color.fromARGB(255, 19, 133, 99);
      secondaryColor = Colors.white;
      gradientColor = const Color.fromARGB(255, 39, 165, 115);
    }
  }
}
