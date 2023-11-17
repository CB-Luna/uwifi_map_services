import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';

class PopPortabilityAlreadyDone extends StatelessWidget {
  const PopPortabilityAlreadyDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    return Container(
            padding: const EdgeInsets.all(10),
            height: 250,
            width: 560,
            decoration: buildBoxDecoration(image: 'images/blue_circles.png'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  "You have already done this process, please move on to the next step",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 20 : 30,
                    height: 1,
                    color: const Color(0xff001E4D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                CustomOutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        },
                      text: 'Continue',
                      bgColor: const Color(0xFFD20030),
                    ),
                const SizedBox(height: 10),
              ],
            ),
          );
  }


  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}