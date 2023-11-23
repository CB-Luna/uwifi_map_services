import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';

class CustomCardSupportedDevices extends StatelessWidget {
   final int index; 
   final String name;
   final double cost;
   final String image;
  const CustomCardSupportedDevices({
    Key? key, 
    required this.index,
    required this.name,
    required this.cost,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    bool isSelected = cartController.devices[index].isSelected!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: SizedBox(
              height: 100,
              width: 190,
              child: Stack(children: [
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: getDecoration(isSelected),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                          child: Stack(
                            children: [
                              Container(
                                width: 45,
                                height: 75,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFB9D4FC),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                    ),
                                ),
                              ),
                              Center(
                                child: Image.network(
                                  image, 
                                  height: 45,
                                  ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.workSans(
                                fontSize: 14,
                                color: const Color(0xff2E5899),
                                fontWeight: FontWeight.bold,
                                 letterSpacing: -1.0,
                              ),
                            ),
                            Text(
                              "Extra streaming device",
                              style: GoogleFonts.workSans(
                                fontSize: 10,
                                color: const Color(0xFF8AA7D2),
                                fontWeight: FontWeight.normal,
                                letterSpacing: -1.0,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              cartController.devices[index].quantity > 0 ? "\$ ${cartController.devices[index].quantity * cost.toInt()}/mo": "\$${cost.toInt()}/mo",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: const Color(0xFF8AA7D2),
                                fontWeight: FontWeight.normal,
                                letterSpacing: -1.0,
                              ),
                            ),
                             Row(
                               children: [
                                 InkWell(
                                     onTap: () {
                                 
                                     },
                                     child: const Icon(
                                       Icons.remove_circle_outline,
                                       color: Color(0xff2E5899),
                                       size: 25,
                                     )),
                                 Container(
                                   margin: const EdgeInsets.symmetric(horizontal: 3),
                                   child: Text(
                                     cartController.devices[index].quantity.toString(),
                                     style: GoogleFonts.roboto(
                                     fontSize: 18,
                                     color: const Color(0xFF8AA7D2),
                                     fontWeight: FontWeight.normal,
                                     letterSpacing: -2.0,
                                     ),
                                   ),
                                 ),
                                  InkWell(
                                     onTap: () {
                               
                                     },
                                     child: const Icon(
                                       Icons.add_circle_outline,
                                       color: Color(0xff2E5899),
                                       size: 25,
                                     )),
                               ],
                             ),
                          ],
                        )
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
