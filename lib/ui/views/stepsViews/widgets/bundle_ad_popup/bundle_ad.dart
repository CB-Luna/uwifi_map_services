import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';
import '../../../../../classes/popup.dart';
import '../../../../../classes/product.dart';
import '../../../../../data/constants.dart';

void popupBundleAd(BuildContext context, plans, controller) {
  showDialog(
      barrierColor: const Color(0x00022963).withOpacity(0.40),
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BundleAd(plans: plans, controller: controller);
      });
}

class BundleAd extends StatelessWidget with Popup {
  final List<Plan> plans;
  final PlanController controller;

  const BundleAd({Key? key, required this.plans, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 700 ? true : false;
    double boxPadding = mobile ? 10.0 : 30.0;
    ScrollController scrollController = ScrollController();

    final cartController = Provider.of<Cart>(context);

    final double? featureFontSize = lerpDouble(12, 16, equiv(context));
    final double? nameFontSize = lerpDouble(13, 24, equiv(context));

    Color secondaryColor = const Color(0XFFd20030);
    Color primaryColor = const Color(0xFF2E5899);
    Color accentColor = const Color(0xFF37BE88);
    plans.sort((a, b) => b.price!.compareTo(a.price!));

    void selectBundle(Plan plan) {
      Product product = Product(
        id: plan.id,
        name: plan.name!,
        cost: plan.price!,
        imageurl: '../assets/images/swipes.png',
        service: '',
        category: plan.planCategory,
        quantity: 1,
        pwName: plan.pwName ?? '',
      );

      if (plan.isEnabled) {
        if (!plan.isSelected) {
          //Primero limpiamos informacion previa según el servicio seleccionado
          cartController.cleanByCategory(plan.planCategory);

          //Se selecciona el plan específico
          //  plansController.selectPlan(plan);
          for (var p in plans) {
            p.isSelected = false;
          }

          controller.plansActivation([plan.planCategory], false);

          plan.isSelected = true;
          cartController.validateAddProduct(product);
        }
      }
    }

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 850),
        decoration: buildBoxDecoration(
            image: 'images/bg_image.png',
            fit: mobile ? BoxFit.cover : BoxFit.fitWidth,
            alignment: mobile ? Alignment.bottomLeft : Alignment.topLeft),
        child: Container(
            padding: EdgeInsets.all(boxPadding),
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Wrap(
                          textDirection:
                              mobile ? TextDirection.rtl : TextDirection.ltr,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            FractionallySizedBox(
                              widthFactor: mobile ? 1.0 : 0.6,
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        for (var plan in plans)
                                          MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectBundle(plan);
                                              },
                                              child: BundleCard(
                                                  plan: plan,
                                                  nameFontSize: nameFontSize,
                                                  featureFontSize:
                                                      featureFontSize),
                                            ),
                                          ),
                                      ],
                                    ),
                                    if (mobile)
                                      Wrap(
                                        children: [
                                          BundlePopupButton(
                                              isFilled: true,
                                              text: "Select",
                                              accentColor: accentColor,
                                              function: () =>
                                                  selectBundle(plans.first)),
                                          BundlePopupButton(
                                            text: "Close",
                                            accentColor: secondaryColor,
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              alignment: Alignment.topLeft,
                              widthFactor: mobile ? 1.0 : 0.4,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: mobile ? 15.0 : 0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text(plans.first.featTitle ?? "",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: mobile
                                                ? nameFontSize
                                                : (nameFontSize! + 15),
                                            color: secondaryColor,
                                            fontWeight: FontWeight.w700,
                                          )),
                                      Text(plans.first.featDesc ?? "",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: mobile ? 16.0 : 20.0,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                            "SUPERgig INTERNET + G2 TV for \$138. Upgrade or add any services for just \$20.",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.workSans(
                                                fontSize: mobile ? 12.0 : 16.0,
                                                color: primaryColor,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: -0.25)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (!mobile)
                                        Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          children: [
                                            FractionallySizedBox(
                                              widthFactor: 0.5,
                                              child: BundlePopupButton(
                                                  text: "Select",
                                                  isFilled: true,
                                                  accentColor: accentColor,
                                                  function: () => selectBundle(
                                                      plans.first)),
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: 0.5,
                                              child: BundlePopupButton(
                                                text: "Close",
                                                accentColor: secondaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                    ]),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class BundlePopupButton extends StatelessWidget {
  const BundlePopupButton({
    Key? key,
    required this.text,
    required this.accentColor,
    this.function,
    this.isFilled,
  }) : super(key: key);

  final String text;
  final Color accentColor;
  final Function? function;
  final bool? isFilled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.0, color: accentColor),
                borderRadius: BorderRadius.circular(30.0)),
            backgroundColor: isFilled != null ? accentColor : Colors.white,
            minimumSize: const Size.fromHeight(50)),
        onPressed: () {
          if (function != null) function!();
          Navigator.pop(context);
        },
        child: Text(text,
            style: GoogleFonts.workSans(
                height: 1.5,
                fontSize: 16,
                color: isFilled != null ? Colors.white : accentColor,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.1)),
      ),
    );
  }
}

class BundleCard extends StatelessWidget {
  const BundleCard({
    Key? key,
    required this.plan,
    required this.nameFontSize,
    required this.featureFontSize,
  }) : super(key: key);

  final Plan plan;
  final double? nameFontSize;
  final double? featureFontSize;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: mobile(context) ? 1 : 0.5,
      child: Container(
        margin: const EdgeInsets.all(15),
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
              color: const Color.fromARGB(255, 4, 52, 124).withOpacity(0.75),
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
