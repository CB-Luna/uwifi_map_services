import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Enum value;
  final Enum groupValue;
  final double? width;
  final Function function;

  const CustomRadioButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.value,
      required this.groupValue,
      required this.function,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;

    return Container(
      height: mobile ? 130 : 170,
      width: mobile ? 115 : width ?? 150,
      decoration: getDecoration(value, groupValue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Icon(
            icon,
            color: const Color(0xff2E5899),
            size: mobile ? 45 : 60,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
              fontSize: 16,
              height: 1,
              color: const Color(0xff2E5899),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Spacer(),
              Transform.scale(
                scale: 0.75,
                child: Radio(
                  value: value,
                  activeColor: const Color(0xFFD20030),
                  groupValue: groupValue,
                  onChanged: (Enum? value) {
                    function(value!);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Decoration getDecoration(value, groupValue) {
    late final Color borderColor;
    if (value == groupValue) {
      borderColor = const Color(0xFFD20030);
    } else {
      borderColor = const Color(0xff8AA7D2);
    }
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borderColor, width: 2.5),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  String parseLocation(String location) {
    String parsedText = '';
    switch (location) {
      case 'cry':
        parsedText = "Crystal Beach";
        break;

      case 'ode':
        parsedText = "Midland - Odessa";
        break;

      case 'smi':
        parsedText = "Smithville";
        break;
    }
    return parsedText;
  }
}
