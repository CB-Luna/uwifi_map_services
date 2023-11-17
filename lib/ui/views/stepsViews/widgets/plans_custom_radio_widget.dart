import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../providers/plan_controller.dart';

class PlansCustomRadio extends StatelessWidget {
  final Plan plan;
  final bool isTherePromo;
  final bool? isPromoApplied;
  final Products? promo;

  const PlansCustomRadio(
      {Key? key,
      required this.plan,
      required this.isTherePromo,
      this.isPromoApplied,
      this.promo})
      : super(key: key);

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

    final double? cardPadding = lerpDouble(15, 25, equiv);
    final double? cardBottomPadding = lerpDouble(0, 25, equiv);
    final double? featureFontSize = lerpDouble(10, 14, equiv);
    final double? nameFontSize = lerpDouble(15, 22, equiv);
    final plansController = Provider.of<PlanController>(context);

    return Card(
        shadowColor: const Color(0x506FA5DB),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(
            vertical: mobile ? 10.0 : 12.5, horizontal: 0.0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: plan.isSelected
                  ? const Color(0xFFD20300)
                  : const Color(0xffD8E3F2),
              width: plan.isSelected ? 2.0 : 0.5),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  top: cardPadding!,
                  left: cardPadding,
                  right: cardPadding,
                  bottom: cardBottomPadding!),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                    runSpacing: 10.0,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      FractionallySizedBox(
                        widthFactor: size.width < 1700 ? 1 : 0.6,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan.name ?? "",
                                  style: GoogleFonts.workSans(
                                      fontSize: nameFontSize,
                                      color: plan.isEnabled
                                          ? const Color(0xFF2e5899)
                                          : const Color(0xFF8AA7D2),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1.0)),
                              Text(plan.featTitle ?? "",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: featureFontSize,
                                      color: plan.isEnabled
                                          ? const Color(0xFFD20300)
                                          : const Color(0xFFBAD2F2),
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.5)),
                              Text(plan.featDesc ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: GoogleFonts.workSans(
                                    fontSize: 12.0,
                                    color: plan.isEnabled
                                        ? const Color(0xFF2e5899)
                                        : const Color(0xFF8AA7D2),
                                    fontWeight: FontWeight.normal,
                                  )),
                            ]),
                      ),
                      FractionallySizedBox(
                        widthFactor: size.width < 1700 ? 1 : 0.4,
                        child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: size.width < 1700
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "\$ ${promo != null ? plansController.setPromoPrice(plan.price!, promo!).toString() : plan.price.toString()}",
                                  style: GoogleFonts.workSans(
                                      fontSize: mobile ? 22 : 26,
                                      color: plan.isEnabled
                                          ? const Color(0xFF2e5899)
                                          : const Color(0xFF8AA7D2),
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -1.0)),
                              Text('/mo',
                                  style: GoogleFonts.workSans(
                                      fontSize: mobile ? 14 : 16,
                                      color: plan.isEnabled
                                          ? const Color(0xFF2e5899)
                                          : const Color(0xFF8AA7D2),
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -1.0))
                            ]),
                      ),
                    ]),
              )),
          plan.isComing!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    comingSoonArea(),
                  ],
                )
              : isTherePromo
                  ? Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            promoArea(isPromoApplied != null),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            bottom(plan.isEnabled, plan.isSelected),
                          ],
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        bottom(plan.isEnabled, plan.isSelected),
                      ],
                    ),
        ]));
  }

  Widget comingSoonArea() {
    final area = Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            spreadRadius: -15,
            color: Color(0x506FA5DB),
            offset: Offset(0, 15),
          )
        ],
        color: const Color.fromARGB(210, 0, 35, 88),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.white,
            size: 18.0,
          ),
          const SizedBox(width: 5),
          Text("Coming Soon",
              style: GoogleFonts.workSans(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2)),
        ],
      ),
    );
    return area;
  }

  Widget promoArea(bool promoApplied) {
    final area = Container(
      decoration: BoxDecoration(
        color: promoApplied
            ? const Color(0xffd20030)
            : const Color.fromARGB(194, 255, 164, 27),
        border: Border.all(
            color: promoApplied
                ? const Color(0xffd20030)
                : const Color.fromARGB(194, 255, 164, 27),
            width: 1), // added
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sell,
            color: Colors.white,
            size: 14.0,
          ),
          const SizedBox(width: 5),
          Text(promoApplied ? "Promo Applied" : "Available Promo",
              style: GoogleFonts.workSans(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2)),
        ],
      ),
    );
    return area;
  }

  Widget promoApplied() {
    final area = Container(
      decoration: BoxDecoration(
        color: const Color(0xFFd20030),
        border: Border.all(color: const Color(0xFFd20030), width: 1), // added
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sell,
            color: Colors.white,
            size: 14.0,
          ),
          const SizedBox(width: 5),
          Text("Available promo",
              style: GoogleFonts.workSans(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2)),
        ],
      ),
    );
    return area;
  }

  Widget bottom(planEnabled, planSelected) {
    final Color containerColor =
        planSelected ? const Color(0xFFd20030) : Colors.white;
    final Color borderColor = planEnabled
        ? planSelected
            ? const Color(0xFFd20030)
            : const Color(0xFFD8E3F2)
        : Colors.white;

    final button = AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          color: containerColor, // added
          border: Border.all(color: borderColor, width: 1), // added
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
            children: planEnabled
                ? planSelected
                    ? [const Icon(Icons.done, color: Colors.white, size: 12)]
                    : [
                        Text("Select",
                            style: GoogleFonts.workSans(
                                fontSize: 12,
                                color: const Color(0xFF8AA7D2),
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2)),
                        const SizedBox(width: 5),
                        const Icon(Icons.circle_outlined,
                            color: Color(0xFF8AA7D2), size: 10)
                      ]
                : [const Text("")]));

    return button;
  }
}
