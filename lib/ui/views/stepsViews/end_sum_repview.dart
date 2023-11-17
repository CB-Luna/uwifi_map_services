import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import '../../../providers/customer_info_controller.dart';

class RepToggles extends StatefulWidget {
  const RepToggles({Key? key}) : super(key: key);

  @override
  State<RepToggles> createState() => _RepTogglesState();
}

class _RepTogglesState extends State<RepToggles> {
  final List<bool> selectionsServiveRequest =
      List.generate(1, (index) => false);
  final List<bool> selectionsTV = List.generate(1, (index) => false);
  final List<bool> selectionsVoice = List.generate(1, (index) => false);
  @override
  Widget build(BuildContext context) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? headerfontSize = lerpDouble(13, 26, (appwidth - 500) / maxAppWidth);
    double? bodyfontSize = lerpDouble(10, 18, (appwidth - 500) / maxAppWidth);
    double? iconSize = lerpDouble(25, 40, (appwidth - 500) / maxAppWidth);
    final customerController = Provider.of<CustomerInfoProvider>(context);
    final cartController = Provider.of<Cart>(context);
    bool isDisableToogleTV = cartController.isSelectedGigFastTV();
    bool isDisableToogleVoice = cartController.isSelectedGigFastVoice();
    bool isVisibleToogleInternet =
        customerController.customerInfo.locationGroup == 'SMI';
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF8AA7D2), Color(0xFF2E5899)]),
            borderRadius: BorderRadius.circular(35),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 68, 68, 68),
                  blurRadius: 5,
                  offset: Offset(0, 5))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Select the Tickets that will be created',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: headerfontSize,
                    ),
                  ),
                ),
                SizedBox(
                  width: respSize.width * 0.02,
                ),
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      const Color(0xFFD20030).withOpacity(0.85),
                    )),
                    onPressed: () {
                      setState(() {
                        if (isVisibleToogleInternet == true) {
                          selectionsServiveRequest[0] = true;
                          customerController.ticketServiceRequest = true;
                        } else {
                          selectionsServiveRequest[0] = false;
                          customerController.ticketServiceRequest = false;
                        }
                        if (isDisableToogleTV == true) {
                          selectionsTV[0] = true;
                          customerController.ticketTV = true;
                        } else {
                          selectionsTV[0] = false;
                          customerController.ticketTV = false;
                        }

                        if (isDisableToogleVoice == true) {
                          selectionsVoice[0] = true;
                          customerController.ticketVoice = true;
                        } else {
                          selectionsVoice[0] = false;
                          customerController.ticketVoice = false;
                        }
                        // print('TV is ${customerController.ticketTV}');
                        // print('Phone is ${customerController.ticketVoice}');
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Text(
                        'Select All',
                        style: GoogleFonts.getFont(
                          'Work Sans',
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                          fontSize: bodyfontSize,
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: respSize.height * 0.02,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: [
                  Visibility(
                    visible: isVisibleToogleInternet,
                    child: ToggleButtons(
                      constraints: BoxConstraints(
                          minWidth: respSize.width * 0.1,
                          maxWidth: double.infinity,
                          minHeight: respSize.height * 0.1,
                          maxHeight: double.infinity),
                      isSelected: selectionsServiveRequest,
                      onPressed: (int index) {
                        setState(() {
                          selectionsServiveRequest[index] =
                              !selectionsServiveRequest[index];
                          customerController.ticketServiceRequest =
                              selectionsServiveRequest[index];
                          // print('TV is ${customerController.ticketTV}');
                          // print('Phone is ${customerController.ticketVoice}');
                        });
                      },
                      color: Colors.grey,
                      selectedBorderColor: const Color(0xFFDFEDFF),
                      fillColor: const Color(0xFFD20030),
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 2,
                      hoverColor: const Color(0xFF8AA7D2),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(bodyfontSize!),
                          child: Image.asset('images/new_service_request.png',
                              height: iconSize,
                              fit: BoxFit.contain,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ToggleButtons(
                    constraints: BoxConstraints(
                        minWidth: respSize.width * 0.1,
                        maxWidth: double.infinity,
                        minHeight: respSize.height * 0.1,
                        maxHeight: double.infinity),
                    isSelected: selectionsTV,
                    onPressed: isDisableToogleTV
                        ? (int index) {
                            setState(() {
                              selectionsTV[index] = !selectionsTV[index];
                              customerController.ticketTV = selectionsTV[index];
                              // print('TV is ${customerController.ticketTV}');
                              // print('Phone is ${customerController.ticketVoice}');
                            });
                          }
                        : null,
                    color: Colors.grey,
                    selectedBorderColor: const Color(0xFFDFEDFF),
                    fillColor: const Color(0xFFD20030),
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 2,
                    hoverColor: const Color(0xFF8AA7D2),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(bodyfontSize),
                        child: Image.asset('images/gigFastTV.png',
                            height: iconSize,
                            fit: BoxFit.contain,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  ToggleButtons(
                    constraints: BoxConstraints(
                        minWidth: respSize.width * 0.1,
                        maxWidth: double.infinity,
                        minHeight: respSize.height * 0.1,
                        maxHeight: double.infinity),
                    isSelected: selectionsVoice,
                    onPressed: isDisableToogleVoice
                        ? (int index) {
                            setState(() {
                              selectionsVoice[index] = !selectionsVoice[index];
                              customerController.ticketVoice =
                                  selectionsVoice[index];

                              // print('TV is ${customerController.ticketTV}');
                              // print('Phone is ${customerController.ticketVoice}');
                            });
                          }
                        : null,
                    color: Colors.grey,
                    selectedBorderColor: const Color(0xFFDFEDFF),
                    fillColor: const Color(0xFFD20030),
                    borderRadius: BorderRadius.circular(5),
                    borderWidth: 2,
                    hoverColor: const Color(0xFF8AA7D2),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(bodyfontSize),
                        child: Image.asset('images/gigFastVoice.png',
                            height: iconSize,
                            fit: BoxFit.contain,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
