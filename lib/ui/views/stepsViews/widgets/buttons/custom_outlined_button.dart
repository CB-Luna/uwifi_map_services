import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;

  const CustomOutlinedButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.bgColor = Colors.transparent,
    this.borderColor = colorSecondary,
    this.textColor = colorBgWhite,
    this.fontSize = 13,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: borderColor,
            width: 3,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(bgColor),
      ),
      onPressed: () => onPressed != null ? onPressed!() : null,
      child: Text(
        text,
        style: TextStyle(
        color: textColor,
        fontSize: 12,
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
