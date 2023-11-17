import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';

class TVPopupSetTopBox extends StatelessWidget {
  const TVPopupSetTopBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Don\'t have one of these devices?',
          style: GoogleFonts.workSans(
            fontSize: 12,
            color: const Color(0xFF8AA7D2),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            CustomOutlinedButton(
              onPressed: () {
                cartController.changeVisibilitySupportedDevices();
              },
              text: 'Get Set-top Box',
              bgColor: Colors.white,
              textColor: const Color(0xFFD20030),
              borderColor: const Color(0xFFD20030),
              padding: const EdgeInsets.all(5),
            ),
            const SizedBox(width: 15),
            Image(
              image: const AssetImage('images/devices/set-top_box.png'),
              width: desktop ? 50 : 30,
            )
          ],
        ),
      ],
    );
  }
}
