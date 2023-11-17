import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../classes/popup.dart';
import '../../../../providers/customer_info_controller.dart';

import '../../stepsViews/customer_info_checks.dart';

void popupAcknowledge(BuildContext context) {
  final serviceController =
      Provider.of<CustomerInfoProvider>(context, listen: false);
  showDialog(
      barrierColor: const Color(0x00022963).withOpacity(0.40),
      context: context,
      builder: (_) {
        return AcknowledgePopup(controller: serviceController);
      });
}

class AcknowledgePopup extends StatelessWidget with Popup {
  final CustomerInfoProvider controller;
  const AcknowledgePopup({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    final size = MediaQuery.of(context).size;

    const double minWidth = 900.0;
    const double maxRangeValue = 1300.0;
    final double equiv =
        (size.width < minWidth ? 0 : (size.width - minWidth)) / maxRangeValue;

    // double? headerFontSize = lerpDouble(16, 20, equiv);
    // double? bodyFontSize = lerpDouble(11, 14, equiv);
    double? titleFontSize = lerpDouble(25, 35, equiv);

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      content: Container(
        padding: const EdgeInsets.all(25),
        constraints: const BoxConstraints(maxWidth: 850, maxHeight: 450),
        decoration: buildBoxDecoration(
            image: 'images/bg_gradient.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Important Notice about your installation:',
                  style: GoogleFonts.getFont('Poppins',
                      color: const Color(0xFFd20030),
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize)),
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    controller: scrollController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.customerInfo.coverageType == 'Fiber'
                              ? fiberInstall(context)
                              : wirelessInstall(context),
                          const AckCheckbox()
                        ]),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

Widget wirelessInstall(BuildContext context) {
  const int maxAppWidth = 1800;
  final respSize = MediaQuery.of(context).size;
  var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
  double? headerfontSize = lerpDouble(14, 22, (appwidth - 500) / maxAppWidth);
  double? bodyfontSize = lerpDouble(12, 18, (appwidth - 500) / maxAppWidth);
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Fixed Wireless Service Installation',
              style: GoogleFonts.getFont(
                'Work Sans',
                color: const Color(0xFF2E5899),
                fontWeight: FontWeight.w700,
                fontSize: headerfontSize,
              ),
            ),
            const Divider(
              thickness: 2,
              color: Color(0xFF8AA7D2),
            )
          ],
        ),
      ],
    ),
    Text(
      '• We deliver internet by placing a dish on your roof or attached to the side of your home with an extend pole and penetrate your home with an ethernet cable to bring the service into your home. We seal all entry points to avoid leaks and damage.\n\n •Once mounted, we wirelessly connect to one of our towers to provide internet to your home.\n\n •The technician will review mounting options with you before any work begins to make sure you are comfortable with our approach!\n',
      style: GoogleFonts.getFont(
        'Work Sans',
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: bodyfontSize,
      ),
    ),
  ]);
}

Widget fiberInstall(BuildContext context) {
  const int maxAppWidth = 1800;
  final respSize = MediaQuery.of(context).size;
  var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
  double? headerfontSize = lerpDouble(14, 22, (appwidth - 500) / maxAppWidth);
  double? bodyfontSize = lerpDouble(12, 18, (appwidth - 500) / maxAppWidth);
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Fiber Service Installation',
              style: GoogleFonts.getFont(
                'Work Sans',
                color: const Color(0xFF2E5899),
                fontWeight: FontWeight.w700,
                fontSize: headerfontSize,
              ),
            ),
            const Divider(
              thickness: 2,
              color: Color(0xFF8AA7D2),
            )
          ],
        ),
      ],
    ),
    Text(
      '• We deliver internet by running a fiber line from our closest connection point (utility pole or underground handhold) to your home either aerial or by trenching underground.\n\n• We mount a box to the side of your home, usually next to your power meter and penetrate your home with an ethernet cable to bring the service into your home.\n\n• We seal all entry points to avoid leaks or damage.\n',
      style: GoogleFonts.getFont(
        'Work Sans',
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: bodyfontSize,
      ),
    ),
  ]);
}
