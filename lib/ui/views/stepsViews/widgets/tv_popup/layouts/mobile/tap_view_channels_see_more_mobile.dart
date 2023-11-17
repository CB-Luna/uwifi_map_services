import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/square_image.dart';

const Color iconBackgroundColor = Color.fromARGB(255, 8, 43, 95);
const Color backgroundColor = Color(0xFF2e5899);

class TapViewChannelsSeeMoreMobile extends StatelessWidget {
  final List channels;
  final String idTV;
  final int index;
  const TapViewChannelsSeeMoreMobile({
    Key? key,
    required this.channels,
    required this.idTV,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 880 ? true : false;
    final scrollController = ScrollController();
    String title = getTittleSection(index);
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.workSans(
              height: 1.5,
              fontSize: 26,
              color: const Color(0xFF2e5899),
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 300,
          width: 270,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff8AA7D2)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
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
                      direction: Axis.horizontal,
                      spacing: 8,
                      runSpacing: 10,
                      children: List.generate(channels.length, (i) {
                        if (channels[i].tvChannelLineUp.contains(idTV)) {
                          return SquareImage(
                            size: mobile ? 40 : 65,
                            image: channels[i].picture ??
                                "https://pim.cbluna-dev.com/media/cache/thumbnail_small/6/0/3/7/6037a58331d319c6e19cbe8b25563dbee353febf_93___NHL.png",
                            text: channels[i].name ?? 'Channel',
                          );
                        } else {
                          return SquareImage(
                              size: mobile ? 40 : 65,
                              image: channels[i].picture ??
                                  "https://pim.cbluna-dev.com/media/cache/thumbnail_small/6/0/3/7/6037a58331d319c6e19cbe8b25563dbee353febf_93___NHL.png",
                              text: channels[i].name ?? 'Channel',
                              isAvailable: false,
                              description: channels[i].description);
                        }
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getTittleSection(int index) {
    switch (index) {
      case 0:
        return 'All';
      case 1:
        return 'Sports';
      case 2:
        return 'News';
      case 3:
        return 'Movies';
      case 4:
        return 'Music';
      case 5:
        return 'Kids';
      default:
        return 'All';
    }
  }
}

class FeatureBlocItem extends StatelessWidget {
  final IconData iconData;
  final String description;

  //One learning - YOu cannot use Row here because of equal placements.. Table or reversing Row with Column will work. Let's see.

  const FeatureBlocItem({
    Key? key,
    required this.iconData,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClayContainer(
            height: 40,
            width: 40,
            depth: 15,
            borderRadius: 12,
            parentColor: Colors.white,
            curveType: CurveType.convex,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: backgroundColor, width: 1.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: backgroundColor, width: 0.8),
                ),
                child: Icon(
                  iconData,
                  color: iconBackgroundColor,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 180,
            child: Text(
              description,
              maxLines: 2,
              style: const TextStyle(
                color: Color(0xFF2e5899),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
