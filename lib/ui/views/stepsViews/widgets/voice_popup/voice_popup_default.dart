import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/voice_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/slider_card.dart';

import '../../../../../classes/popup.dart';
import '../expanded_widget.dart';

class VoiceDefault extends StatelessWidget with Popup {
  final Plan plan;
  final String customerType;
  const VoiceDefault({
    Key? key,
    required this.plan,
    required this.customerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    double boxPadding = mobile ? 30.0 : 40.0;

    const int maxAppWidth = 1800;
    var appwidth = size.width < maxAppWidth ? size.width : maxAppWidth;
    double? bodyfontSize = lerpDouble(10, 14, (appwidth - 500) / maxAppWidth);

    final cartController = Provider.of<Cart>(context);
    final voicePopupController = Provider.of<VoicePopupController>(context);

    final idVoice = plan.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cartController.fees.isEmpty) {
        cartController.addFeesToCart(voicePopupController.fees);
      } else {
        for (var i = 0; i < voicePopupController.fees.length; i++) {
          List<Product> contains = cartController.fees
              .where((item) =>
                  item.category == voicePopupController.fees[i].category)
              .toList();

          if (contains.isEmpty) {
            cartController.addFeesToCart(voicePopupController.fees);
          }
        }
      }
    });
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.all(boxPadding),
            width: 840,
            decoration: buildBoxDecoration(
                image:
                    mobile ? 'images/bg_image.png' : 'images/sideCircles.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                bgColor: Colors.white),
            child: Wrap(children: [
              FractionallySizedBox(
                widthFactor: mobile ? 1.0 : 0.5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(children: [
                                      Image.asset(
                                          'images/icon_gigFastVoice.png',
                                          width: 50,
                                          height: 50),
                                      const SizedBox(width: 10),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              Text(plan.name!,
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 25,
                                                      color: const Color(
                                                          0xFF2e5899),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: -0.5)),
                                              const SizedBox(width: 25),
                                              Wrap(children: [
                                                Text("\$${plan.price}",
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 26,
                                                        color: const Color(
                                                            0xFF2e5899),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: -1.0)),
                                                Text("/mo",
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 16,
                                                        color: const Color(
                                                            0xFF2e5899),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        letterSpacing: -1.0))
                                              ])
                                            ]),
                                            Text(
                                                "${plan.featTitle!} ${plan.featDesc!}",
                                                style: GoogleFonts.workSans(
                                                    fontSize: 18,
                                                    color:
                                                        const Color(0xFFd20030),
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: -0.5))
                                          ])
                                    ]),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(plan.description!,
                                  style: GoogleFonts.workSans(
                                      fontSize: bodyfontSize,
                                      color: const Color(0xFF8AA7D2),
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.2)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: mobile
                                ? ExpandedWidget(
                                    boxPadding: 0,
                                    title: 'An ATA will be required',
                                    text:
                                        "You can purchase an ATA device starting at \$50 or you can purchase a third-party ATA on your own. \n\nMore information will be provided to you when one of our RTA customer representatives gets in contact with you.",
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            const WidgetSpan(
                                              child: Icon(
                                                  MdiIcons.alertCircleOutline,
                                                  size: 16.0,
                                                  color: Color(0xFF8AA7D2)),
                                            ),
                                            TextSpan(
                                              text: 'An ATA will be required',
                                              style: GoogleFonts.workSans(
                                                  fontSize: mobile ? 12 : 16,
                                                  color:
                                                      const Color(0xFF2e5899),
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.5),
                                            ),
                                          ]),
                                        ),
                                        const SizedBox(height: 10),
                                        Wrap(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            FractionallySizedBox(
                                              widthFactor:
                                                  size.width < 900 ? 1.0 : 0.65,
                                              child: Text(
                                                  "You can purchase an ATA device starting at \$50 or you can purchase a third-party ATA on your own. More information will be provided to you when one of our RTA customer representatives gets in contact with you.",
                                                  style: GoogleFonts.workSans(
                                                      height: 1.5,
                                                      fontSize: bodyfontSize,
                                                      color: const Color(
                                                          0xFF8AA7D2),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      letterSpacing: -0.35)),
                                            ),
                                            FractionallySizedBox(
                                              widthFactor:
                                                  size.width < 900 ? 1.0 : 0.25,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 5, mobile ? 0 : 5),
                                                child: Image.asset(
                                                    'images/ATA.png',
                                                    height: size.width < 900
                                                        ? 50
                                                        : 80),
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: !mobile,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: const Color(0xFFd20030),
                              minimumSize: const Size.fromHeight(50)),
                          onPressed: () => Navigator.pop(context, 'Accept'),
                          child: Text('Accept',
                              style: GoogleFonts.workSans(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2)),
                        ),
                      ),
                    ]),
              ),
              FractionallySizedBox(
                widthFactor: mobile ? 1.0 : 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(left: mobile ? 0 : boxPadding),
                        child: ListView(shrinkWrap: true, children: [
                          Wrap(
                            runSpacing: 15,
                            spacing: 30,
                            children: List.generate(
                                voicePopupController.aditionalProducts[idVoice]!
                                    .length, (index) {
                              String id = voicePopupController
                                  .aditionalProducts[idVoice]![index].id;
                              String name = voicePopupController
                                  .aditionalProducts[idVoice]![index].name;
                              String category = voicePopupController
                                      .aditionalProducts[idVoice]![index]
                                      .categories
                                      .isEmpty
                                  ? "None"
                                  : voicePopupController
                                      .aditionalProducts[idVoice]![index]
                                      .categories[0];
                              double cost = double.parse(voicePopupController
                                  .aditionalProducts[idVoice]![index].price);
                              double maxValue = double.parse(
                                  voicePopupController
                                      .aditionalProducts[idVoice]![index]
                                      .maxQuantity);
                              Product additionalLine = Product(
                                id: id,
                                name: name,
                                cost: cost,
                                service: voicePopupController
                                    .aditionalProducts[idVoice]![index].family,
                                category: 'gigFastVoice',
                                index: index,
                                isSelected: false,
                                quantity: 0,
                                pwName: voicePopupController
                                    .aditionalProducts[idVoice]![index].pwName,
                              );
                              cartController.additionalsLine
                                  .add(additionalLine);
                              // print(additional);
                              return SliderCard(
                                id: id,
                                name: name,
                                index: index,
                                description: voicePopupController
                                    .aditionalProducts[idVoice]![index].id,
                                category: category,
                                basePrice: cost,
                                maxValue: maxValue,
                              );
                            }),
                          ),
                        ]),
                      ),
                    ),
                    Visibility(
                      visible: mobile,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            backgroundColor: const Color(0xFFd20030),
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () => Navigator.pop(context, 'Accept'),
                        child: Text('Accept',
                            style: GoogleFonts.workSans(
                                height: 1.5,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2)),
                      ),
                    ),
                  ],
                ),
              ),
            ])),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              splashRadius: 10.0,
              icon: const Icon(
                Icons.close,
                color: Color(0xff8aa7d2),
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        )
      ],
    );
  }
}
