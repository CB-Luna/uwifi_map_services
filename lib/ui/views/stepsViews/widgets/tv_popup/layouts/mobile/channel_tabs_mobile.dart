import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/premium_channel_packs.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_channel_mobile.dart';

class ChannelTabsMobile extends StatelessWidget {
  final String id;
  final int index;
  const ChannelTabsMobile({
    Key? key,
    required this.id, 
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    final packs = tvPopupController.apiResults[id]!.result;
    final size = MediaQuery.of(context).size;
    final bool tablet = 800 < size.width  ? true : false;
    String name = packs[index].name;
    double cost = double.parse(packs[index].price);
    String image = packs[index].picture;
    List<PackItem> channels = packs[index].packItems;
    List<String> groups = packs[index].groups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Or add a premium channel pack:",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 16,
            color: tablet ? const Color(0xFF101E51) : const Color(0xFF2e5899),
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 275,
          // height: 210,
          child: CustomCardChannelMobile(
                index: index,
                name: name,
                image: image,
                cost: cost,
                channels: channels,
                groups: groups,
              ),
          ),
      ],
    );
  }
}
