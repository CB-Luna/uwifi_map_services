import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/premium_channel_packs.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_section_channel.dart';

class ChannelTabs extends StatelessWidget {
  final String id;
  const ChannelTabs({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width <= 880 ? true : false;
    final style = GoogleFonts.workSans(
      fontSize: 11,
      color: const Color(0xFF2e5899),
      fontWeight: FontWeight.bold,
    );
    final packs = tvPopupController.apiResults[id]!.result;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Or add a premium channel pack:",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 16,
            color: const Color(0xFF101E51),
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 560,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border : Border.all(color: mobile ? const Color(0xff8AA7D2) : Colors.white)
          ),
          child: DefaultTabController(
            length: 6,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: const Color(0xFFd20030).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border : Border.all(color: const Color(0xFFd20030), width: 2)),
                      tabs: [
                        for (var pack in packs)
                          Tab(child: Text(pack.name, style: style)),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Color(0xFF8AA7D2),
                ),
                SizedBox(
                  height: 140,
                  child: TabBarView(
                    children: List.generate(packs.length, (index) {
                      String name = packs[index].name;
                      double cost = double.parse(packs[index].price);
                      String image = packs[index].picture;
                      List<PackItem> channels = packs[index].packItems;
                      List<String> groups = packs[index].groups;
                      // cartController.packsPremium = tvPopupController.packagePremiumChannels;
                      return CustomCardSectionChannel(
                        index: index,
                        name: name,
                        image: image,
                        cost: cost,
                        channels: channels,
                        groups: groups,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
