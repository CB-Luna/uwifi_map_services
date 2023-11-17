import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/premium_channel_packs.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/square_image.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_bundle.dart';

class CustomCardChannel extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final double cost;
  final List<PackItem> channels;
  const CustomCardChannel({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
    required this.channels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Cart>(context);
    bool isSelected = controller.packsPremium[index].isSelected!;
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
             controller.changeSelectedPackPremium(index);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                height: 100,
                child: Stack(children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: getDecoration(isSelected),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TVPopupBundle(image: image, size: 65),
                          const SizedBox(width: 2),
                          Text(
                            '\$$cost',
                            style: GoogleFonts.workSans(
                              fontSize: 22,
                              height: 2,
                              color: const Color(0xff2E5899),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            "/mo",
                            style: GoogleFonts.workSans(
                              fontSize: 10,
                              color: const Color(0xFF2e5899),
                              fontWeight: FontWeight.w300,
                              letterSpacing: -1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: isSelected
                        ? Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD20030),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(12)),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ))
                        : Container(
                            height: 20,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFD20030)),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Add',
                                    style: GoogleFonts.workSans(
                                      fontSize: 12,
                                      color: const Color(0xFFD20030),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -2.0,
                                    )),
                                const Icon(
                                  Icons.add,
                                  color: Color(0xFFD20030),
                                  size: 10,
                                )
                              ],
                            ),
                          ),
                  )
                ]),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff8AA7D2)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)),
            padding: const EdgeInsets.all(7.0),
            child: ListView(
              controller: ScrollController(),
              shrinkWrap: true,
              children: [
                Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      for (var channel in channels)
                        SquareImage(
                          size: desktop ? 65 : 30,
                          image: channel.picture,
                          text: channel.name,
                        ),
                    ],
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
