import 'dart:ui';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';

class EndPersonal extends StatelessWidget {
  final String street;
  final String city;
  final String state;
  final String zipcode;

  const EndPersonal(
      {Key? key,
      required this.street,
      required this.city,
      required this.state,
      required this.zipcode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final respSize = MediaQuery.of(context).size;

    final customerController = Provider.of<CustomerInfoProvider>(context);
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: respSize.width > 1060
            ? webView(context, customerController)
            : portView(context, customerController));
  }

  /// VISTAS:

  Widget webView(
      BuildContext context, CustomerInfoProvider customerController) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? headerfontSize = lerpDouble(16, 22, (appwidth - 500) / maxAppWidth);
    double? bodyfontSize = lerpDouble(13, 20, (appwidth - 500) / maxAppWidth);
    double? iconSize = lerpDouble(20, 30, (appwidth - 500) / maxAppWidth);
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_history_outlined,
                      color: const Color(0xFFD20030),
                      size: iconSize,
                    ),
                    SizedBox(
                      width: respSize.width * 0.005,
                    ),
                    Text(
                      'Personal Details',
                      style: GoogleFonts.getFont('Work Sans',
                          color: const Color(0xFF2E5899),
                          fontSize: (headerfontSize! + 2),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Color(0xFF8AA7D2),
              ),
            ],
          ),
        ),
        //Item List
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.person_outlined,
                          color: const Color(0xFF8AA7D2),
                          size: iconSize,
                        ),
                        Text(
                          'Name',
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w500,
                            fontSize: bodyfontSize,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${customerController.firstName} ${customerController.lastName}', //parámetro Nombre
                          textAlign: TextAlign.end,
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w600,
                            fontSize: headerfontSize - 2,
                          ),
                        ),
                      ])
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 10,
              color: Color(0xFFD8E3F2),
            ),
            //Phone
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: const Color(0xFF8AA7D2),
                          size: iconSize,
                        ),
                        Text(
                          'Phone Number',
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w500,
                            fontSize: bodyfontSize,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customerController.phone, //Parámetro Telefono
                          textAlign: TextAlign.end,
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w600,
                            fontSize: headerfontSize - 2,
                          ),
                        ),
                      ])
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 10,
              color: Color(0xFFD8E3F2),
            ),
            //Email
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.mail_outline_rounded,
                          color: const Color(0xFF8AA7D2),
                          size: iconSize,
                        ),
                        Text(
                          'Email',
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w500,
                            fontSize: bodyfontSize,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          customerController.custEmail, //Parámetro Correo
                          textAlign: TextAlign.end,
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w600,
                            fontSize: headerfontSize - 2,
                          ),
                        ),
                      ])
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 10,
              color: Color(0xFFD8E3F2),
            ),
            //Address
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/pointer.png',
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'Address',
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w500,
                            fontSize: bodyfontSize,
                          ),
                        ),
                      ]),
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '$street, $city, $state. $zipcode', //Parámetro Dirección
                          textAlign: TextAlign.end,
                          style: GoogleFonts.getFont(
                            'Work Sans',
                            color: const Color(0xFF2E5899),
                            fontWeight: FontWeight.w600,
                            fontSize: headerfontSize - 2,
                          ),
                        ),
                      ])
                ],
              ),
            ),

            ///
          ],
        ),
      ],
    );
  }

  Widget portView(
      BuildContext context, CustomerInfoProvider customerController) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? headerfontSize = lerpDouble(16, 22, (appwidth - 500) / maxAppWidth);
    double? bodyfontSize = lerpDouble(13, 20, (appwidth - 500) / maxAppWidth);
    double? iconSize = lerpDouble(25, 40, (appwidth - 500) / maxAppWidth);
    return Accordion(
        maxOpenSections: 2,
        contentBorderColor: const Color(0xFF2E5899),
        headerBorderRadius: 5,
        header: Text('Personal Details - ',
            style: GoogleFonts.getFont('Work Sans',
                color: const Color(0xFF2E5899),
                fontSize: headerfontSize,
                fontWeight: FontWeight.bold)),
        headerBackgroundColor: Colors.white,
        leftIcon: Icon(
          Icons.location_history_outlined,
          color: const Color(0xFFD20030),
          size: iconSize,
        ),
        rightIcon: Text('• View Details',
            style: GoogleFonts.getFont('Work Sans',
                color: const Color(0xFF8AA7D2),
                fontSize: bodyfontSize,
                fontWeight: FontWeight.bold)),
        flipRightIconIfOpen: false,
        children: [
          AccordionSection(
            header: Text('Personal Details',
                style: GoogleFonts.getFont('Work Sans',
                    color: const Color(0xFF2E5899),
                    fontSize: headerfontSize,
                    fontWeight: FontWeight.bold)),
            flipRightIconIfOpen: false,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.person_outlined,
                              color: const Color(0xFF8AA7D2),
                              size: iconSize,
                            ),
                            Text(
                              'Name',
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w500,
                                fontSize: bodyfontSize,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${customerController.firstName} ${customerController.lastName}', //parámetro Nombre
                              textAlign: TextAlign.end,
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w600,
                                fontSize: headerfontSize,
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xFFD8E3F2),
                ),
                //Phone
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: const Color(0xFF8AA7D2),
                              size: iconSize,
                            ),
                            Text(
                              'Phone Number',
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w500,
                                fontSize: bodyfontSize,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              customerController.phone, //Parámetro Telefono
                              textAlign: TextAlign.end,
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w600,
                                fontSize: headerfontSize,
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xFFD8E3F2),
                ),
                //Email
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.mail_outline_rounded,
                              color: const Color(0xFF8AA7D2),
                              size: iconSize,
                            ),
                            Text(
                              'Email',
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w500,
                                fontSize: bodyfontSize,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              customerController.custEmail, //Parámetro Correo
                              textAlign: TextAlign.end,
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w600,
                                fontSize: headerfontSize,
                              ),
                            ),
                          ])
                    ],
                  ),
                ),
                const Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Color(0xFFD8E3F2),
                ),
                //Address
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              'images/pointer.png',
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                            Text(
                              'Address',
                              style: GoogleFonts.getFont(
                                'Work Sans',
                                color: const Color(0xFF2E5899),
                                fontWeight: FontWeight.w500,
                                fontSize: bodyfontSize,
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                '$street, $city, $state. $zipcode', //Parámetro Dirección
                                textAlign: TextAlign.end,
                                style: GoogleFonts.getFont(
                                  'Work Sans',
                                  color: const Color(0xFF2E5899),
                                  fontWeight: FontWeight.w600,
                                  fontSize: headerfontSize,
                                ),
                              ),
                            ),
                          ])
                    ],
                  ),
                ),

                ///
              ],
            ),
          ),
        ]);
  }
}
