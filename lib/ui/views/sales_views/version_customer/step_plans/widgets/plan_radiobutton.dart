import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/data/constants.dart';

import '../../../../../../providers/plan_controller.dart';

class PlanRadioButton extends StatelessWidget {
  final Plan plan;
  final bool isTherePromo;
  final bool? isPromoApplied;
  final Products? promo;

  const PlanRadioButton(
      {Key? key,
      required this.plan,
      required this.isTherePromo,
      this.isPromoApplied,
      this.promo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plansController = Provider.of<PlanController>(context);

    var palette = colorsTheme(context);

    //Definición de medidas de los elementos dentro del RadioButton
    //Anchura
    double? parWidth = lerpDouble(120, 160, equiv(context));
    double? priceWidth = lerpDouble(60, 70, equiv(context));
    double? priceTxtSize = lerpDouble(18, 25, equiv(context));

    //Padding y Margin
    double horPadding = 25;
    double horMargin = 15;

    //Variables de cálculo de anchura
    double maxPlansWidth = (screenSize(context).width - cartWidth + 100) /
        plansController.plansCategories.length;

    double? plansWidth = lerpDouble(230, maxPlansWidth, equiv(context));

    bool positionChanged =
        (parWidth! + priceWidth! + 100 - horPadding - horMargin) > plansWidth!;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: horPadding / (positionChanged ? 4 : 2)),
        margin: EdgeInsets.symmetric(horizontal: horMargin / 2, vertical: 7.5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                spreadRadius: -20,
                color: plan.isSelected
                    ? palette.tertiary.withOpacity(0.75)
                    : palette.inversePrimary.withOpacity(0.5),
                offset: const Offset(0, 20),
              )
            ],
            border: Border.all(
                color: plan.isSelected
                    ? palette.tertiary
                    : palette.inversePrimary.withOpacity(0.25),
                width: plan.isSelected ? 2 : 1), // added
            color: plan.isSelected
                ? palette.tertiary.withOpacity(0.25)
                : Colors.white,
            borderRadius: BorderRadius.circular(50)),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            child: Wrap(
                runSpacing: 10.0,
                direction: Axis.horizontal,
                alignment: positionChanged && !(mobile(context))
                    ? WrapAlignment.center
                    : WrapAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: mobile(context) ? null : parWidth,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        radioIcon(plan.isEnabled, plan.isSelected, context),
                        Flexible(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(plan.name ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: tagTitleStyle(context,
                                        color: plan.isEnabled
                                            ? null
                                            : palette.inversePrimary
                                                .withOpacity(0.75))),
                                Text(plan.featTitle ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: plan.isSelected
                                          ? palette.onPrimary
                                          : plan.isEnabled
                                              ? palette.inversePrimary
                                              : const Color(0xFFBAD2F2),
                                      fontWeight: FontWeight.w400,
                                    )),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: priceWidth,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "\$${promo != null ? plansController.setPromoPrice(plan.price!, promo!).toString() : plan.price.toString()}",
                              style: GoogleFonts.workSans(
                                  fontSize: priceTxtSize,
                                  color: plan.isEnabled
                                      ? palette.primary
                                      : palette.inversePrimary,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: -2.0)),
                          Text('/mo',
                              style: GoogleFonts.workSans(
                                  fontSize: 12,
                                  color: plan.isEnabled
                                      ? palette.primary
                                      : palette.inversePrimary,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: -0.5))
                        ]),
                  ),
                ]),
          ),
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
                      ],
                    )
                  : const SizedBox.shrink()
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

  Widget radioIcon(enabled, selected, context) {
    var palette = colorsTheme(context);

    final Color borderColor = enabled
        ? selected
            ? palette.tertiary
            : palette.inversePrimary
        : palette.inversePrimary.withOpacity(0.25);

    final button = AnimatedContainer(
      margin: const EdgeInsets.only(right: 7.5),
      width: 25,
      height: 25,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: borderColor, width: selected ? 4 : 1), // added
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
    );

    return button;
  }
}
