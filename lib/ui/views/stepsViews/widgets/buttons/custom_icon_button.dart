import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class CustomIconButton extends StatelessWidget {
  final Function? onPressed;
  final Color bgColor;
  final Color color;
  final IconData icon;
  final String text;
  final double size;

  const CustomIconButton({
    Key? key,
    this.onPressed,
    this.bgColor = Colors.transparent,
    this.color = colorSecondary,
    required this.icon,
    this.text =  "",
    this.size = 20,
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
            color: color,
            width: 2,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(bgColor),
      ),
      onPressed: () => onPressed != null ? onPressed!() : null,
      child: Row(
        children: [
          Icon(
            icon,
            size: size,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(
            color: color,
            fontSize: 14,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
