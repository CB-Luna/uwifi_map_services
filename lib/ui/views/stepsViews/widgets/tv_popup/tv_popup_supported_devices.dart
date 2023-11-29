import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/circle_image.dart';

class TVPopupSupportedDevices extends StatelessWidget {
  const TVPopupSupportedDevices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Supported devices",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 16,
            color: const Color(0xFF2e5899),
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: cartController.isSupportedDevicesVisible,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleImage(
                size: desktop ? 50 : 30,
                image: 'images/devices/Roku.png',
                text: 'Roku',
                isNetworkImage: false,
              ),
              const SizedBox(width: 20),
              CircleImage(
                  size: desktop ? 50 : 30,
                  image: 'images/devices/FireTV.png',
                  text: 'Fire TV',
                  isNetworkImage: false,
                  isRecommended: true),
              const SizedBox(width: 20),
              CircleImage(
                size: desktop ? 50 : 30,
                image: 'images/devices/AppleTV.png',
                text: 'Apple TV',
                isNetworkImage: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
