import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';

import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/square_image.dart';

class TapViewChannelsSeeMore extends StatelessWidget {
  final List channels;
  final String idTV;
  const TapViewChannelsSeeMore({
    Key? key,
    required this.channels,
    required this.idTV,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var channelsSpecific = [for (var channel in channels) if (channel['tvChannelLineUp'].contains(idTV))];
    final tvPopupController = Provider.of<TVPopupController>(context);
    List channelsAvailable =
        tvPopupController.getChannelsAvailableSeeMore(channels, idTV);
    List channelsNotAvailable =
        tvPopupController.getChannelsNotAvailableSeeMore(channels, idTV);
    final size = MediaQuery.of(context).size;
    final scrollController = ScrollController();
    final bool mobile = size.width < 880 ? true : false;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff8AA7D2)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView(
            shrinkWrap: true,
            controller: scrollController,
            children: [
              Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    for (var channel in channelsAvailable)
                      SquareImage(
                        size: mobile ? 40 : 65,
                        image: channel.picture ??
                            "https://pim.cbluna-dev.com/media/cache/thumbnail_small/6/0/3/7/6037a58331d319c6e19cbe8b25563dbee353febf_93___NHL.png",
                        text: channel.name ?? 'Channel',
                      ),
                    for (var channel in channelsNotAvailable)
                      SquareImage(
                          size: mobile ? 40 : 65,
                          image: channel.picture ??
                              "https://pim.cbluna-dev.com/media/cache/thumbnail_small/6/0/3/7/6037a58331d319c6e19cbe8b25563dbee353febf_93___NHL.png",
                          text: channel.name ?? 'Channel',
                          isAvailable: false,
                          description: channel.description),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
