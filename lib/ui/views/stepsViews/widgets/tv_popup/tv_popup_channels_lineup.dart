import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/circle_image.dart';

class TVPopupChannelsLineup extends StatelessWidget {
  final String id;
  const TVPopupChannelsLineup({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TVPopupController>(context);
    final channels = controller.apiResults[id]!.result[0].packItems;
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Channels lineup",
              style: GoogleFonts.workSans(
                height: 1.5,
                fontSize: 16,
                color: const Color(0xFF2e5899),
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 6),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE77690),
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
              onPressed: () => controller.changeView(1),
              child: const Text('See more'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleImage(size: desktop ? 50 : 30, image: channels[0].picture),
            const SizedBox(width: 20),
            CircleImage(size: desktop ? 50 : 30, image: channels[1].picture),
            const SizedBox(width: 20),
            CircleImage(size: desktop ? 50 : 30, image: channels[2].picture),
            const SizedBox(width: 20),
            CircleImage(size: desktop ? 50 : 30, image: channels[3].picture),
          ],
        ),
      ],
    );
  }
}
