import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_bundle.dart';

class CustomCardChannelAvailableMobile extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final double cost;
  const CustomCardChannelAvailableMobile({
    Key? key,
    required this.index,
    required this.name,
    required this.image,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Cart>(context);
    bool isSelected = controller.packsPremium[index].isSelected!;
    return GestureDetector(
          onTap: () {
           controller.changeSelectedPackPremium(index);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              height: 60,
              width: 150,
              child: Stack(children: [
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: getDecoration(isSelected),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TVPopupBundle(image: image, size: 30),
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