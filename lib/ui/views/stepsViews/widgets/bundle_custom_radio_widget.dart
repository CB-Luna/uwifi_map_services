import 'dart:ui';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/bundle_upgrade_switcher.dart';

class BundleCustomRadio extends StatelessWidget {
  final Plan plan;

  const BundleCustomRadio({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 1450 ? true : false;

    const double minWidth = 900.0;

    const double maxRangeValue = 1300.0;
    //Es el valor máximo del rango entre el ancho máximo (2200) y mínimo (900)

    final double equiv =
        (size.width < minWidth ? 0 : (size.width - minWidth)) / maxRangeValue;
    //El porcentaje / equivalente calculado del ancho actual de la pantalla contra los rangos establecidos (maxWidth 1800 y minWidth 900)

    final double? featureFontSize = lerpDouble(10, 14, equiv);
    final double? nameFontSize = lerpDouble(15, 22, equiv);

    final List<Products> upgrades = plan.associations!.pack!.products!
        .where((element) => element.price != null)
        .toList();

    return Opacity(
      opacity: plan.isEnabled ? 1.0 : 0.5,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: mobile ? 10.0 : 12.5),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 107, 154, 223),
                Color.fromARGB(255, 42, 95, 179),
              ]),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  spreadRadius: -15,
                  color:
                      const Color.fromARGB(255, 4, 52, 124).withOpacity(0.75),
                  offset: const Offset(0, 30),
                )
              ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: plan.isSelected
                      ? const Color(0xFFD20300)
                      : Colors.transparent,
                  width: plan.isSelected ? 2.0 : 0.5),
            ),
            child: ClipPath(
              clipper: const CardClipper(),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30,
                        spreadRadius: -15,
                        color: Color.fromARGB(255, 3, 33, 77),
                        offset: Offset(0, 35),
                      )
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 54, 103, 176),
                        Color.fromARGB(255, 14, 50, 108),
                      ],
                    )),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 30,
                        spreadRadius: -15,
                        color: Color.fromARGB(255, 3, 33, 77),
                        offset: Offset(0, 35),
                      )
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: Image.asset('images/icon_gigFastInternet.png',
                        width: 25, height: 25),
                  ),
                  const SizedBox(width: 15),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(plan.name ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                              fontSize: nameFontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Text(plan.featTitle ?? "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: featureFontSize,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(plan.featDesc ?? "",
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                  style: GoogleFonts.workSans(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Text("\$${plan.price}",
                              style: GoogleFonts.workSans(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              )),
                          Text("/mo",
                              style: GoogleFonts.workSans(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: -1.0))
                        ]),
                        const SizedBox(height: 20)
                      ]),
                ]),
              ),
            ),
          ),
          if (upgrades.isNotEmpty)
            plan.isSelected
                ? AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: plan.isSelected ? 1 : 0,
                    curve: Curves.easeInOutBack,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25))),
                        child: Column(
                          children: [
                            Text(
                              "Upgrade or add any services from here for just \$20!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: mobile ? 13 : 16,
                                color: const Color.fromARGB(156, 46, 89, 153),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            for (var upgrade in upgrades)
                              BundleSwitchWidget(
                                product: upgrade,
                                selected: plan.isSelected,
                              )
                          ],
                        )),
                  )
                : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  const CardClipper({Key? key}) : super();

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.15)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height * 0.15)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height * 0.85)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
