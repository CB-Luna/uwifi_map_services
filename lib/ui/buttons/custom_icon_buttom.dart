import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomIconButtom({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.color,
    this.isFilled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(color.withOpacity(0.75)),
          overlayColor: MaterialStateProperty.all(color.withOpacity(1)),
        ),
        onPressed: () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
