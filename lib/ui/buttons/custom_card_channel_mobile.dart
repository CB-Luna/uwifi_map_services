import 'package:flutter/material.dart';
import 'package:uwifi_map_services/classes/premium_channel_packs.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_channel_available_mobile.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_channel_coming_soon_mobile.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/square_image.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/square_image_coming_soon.dart';

class CustomCardChannelMobile extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final double cost;
  final List<PackItem> channels;
  final List<String> groups;
  const CustomCardChannelMobile({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
    required this.channels,
    required this.groups,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    final scrollController = ScrollController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        groups.contains('comingSoon')
            ? CustomCardChannelComingSoonMobile(
                index: index, name: name, image: image, cost: cost)
            : CustomCardChannelAvailableMobile(
                index: index, name: name, image: image, cost: cost),
        Container(
          height: 120,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff8AA7D2)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)),
          padding: const EdgeInsets.all(7.0),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: [
                Center(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: List.generate(channels.length, (i) {
                      if (channels[i].groups.contains('comingSoon')) {
                        return SquareImageCommingSoon(
                          size: desktop ? 65 : 30,
                          image: channels[i].picture,
                          text: channels[i].name,
                        );
                      } else {
                        return SquareImage(
                          size: desktop ? 65 : 30,
                          image: channels[i].picture,
                          text: channels[i].name,
                        );
                      }
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  RoundedRectangleBorder getDecoration(isSelected) {
    late final Color borderColor;
    if (isSelected) {
      borderColor = const Color(0xFFD20030);
    } else {
      borderColor = Colors.white;
    }
    return RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12.0));
  }
}
