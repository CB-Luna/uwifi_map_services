import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tap_view_channels_see_more.dart';

class ChannelsLineup extends StatelessWidget {
  final String id;
  const ChannelsLineup({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    List channelsAvailable = tvPopupController.getChannelsAvailableSeeMore(
        tvPopupController.allChannels, id);
    final numberHDChannels = channelsAvailable.length;
    final scrollControllerVertical = ScrollController();
    final scrollControllerHorizontal = ScrollController();
    final sizeWidth = MediaQuery.of(context).size.width;
    final style = GoogleFonts.workSans(
      fontSize: sizeWidth < 740 ? 11 : 13,
      color: const Color(0xFF2e5899),
      fontWeight: FontWeight.bold,
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(55, 20, 55, 20),
      height: 550,
      decoration: const BoxDecoration(
        color: Color(0xFF2e5899),
      ),
      child: SingleChildScrollView(
        controller: scrollControllerVertical,
        child: SingleChildScrollView(
          controller: scrollControllerHorizontal,
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0)),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: 18,
                      color: Colors.white,
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => tvPopupController.changeView(0),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${id.replaceAll('_', ' ').replaceAll('tv', '')} Package',
                    style: GoogleFonts.workSans(
                        height: 1.5,
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    '$numberHDChannels HD Channels',
                    style: GoogleFonts.workSans(
                        height: 1.5,
                        fontSize: 22,
                        color: const Color(0xFFDFEDFF),
                        fontWeight: FontWeight.w200,
                        letterSpacing: -0.3),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 324,
                width: sizeWidth < 740 ? 450 : sizeWidth * 0.65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
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
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8)),
                            tabs: [
                              Tab(child: Text('All', style: style)),
                              Tab(child: Text('Sports', style: style)),
                              Tab(child: Text('News', style: style)),
                              Tab(child: Text('Movies', style: style)),
                              Tab(child: Text('Music', style: style)),
                              Tab(child: Text('Kids', style: style)),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 5,
                        color: Color(0xFF2e5899),
                      ),
                      SizedBox(
                        height: 240,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: TabBarView(
                            children: [
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.allChannels),
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.sportsChannels),
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.newsChannels),
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.moviesChannels),
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.musicChannels),
                              TapViewChannelsSeeMore(
                                  idTV: id,
                                  channels: tvPopupController.kidsChannels),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
