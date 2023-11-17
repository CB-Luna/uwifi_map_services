import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/end_sum_contact_buttons.dart';

class ContactMCards extends StatefulWidget {
  const ContactMCards({Key? key}) : super(key: key);

  @override
  ContactMCardsState createState() => ContactMCardsState();
}

class ContactMCardsState extends State<ContactMCards> {
  int _value = 3;

  @override
  Widget build(BuildContext context) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? headerfontSize = lerpDouble(18, 20, (appwidth - 500) / maxAppWidth);
    double? bodyfontSize = lerpDouble(14, 16, (appwidth - 500) / maxAppWidth);
    final customerController = Provider.of<CustomerInfoProvider>(context);

    final view = respSize.width > 1200

        //WEB VIEW
        ? Column(
            children: [
              Text(
                "Select your preferred Time & Contact Method: ",
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeOut,
                        // height: _value == 1 ? 145 : 48,
                        width: 155,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: 1,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() => _value = 1);
                                          customerController.contactRange =
                                              '9AM to 12PM';
                                          customerController.contactByPhone =
                                              true;
                                          customerController.contactByEmail =
                                              true;
                                        },
                                        activeColor: Colors.red,
                                      ),
                                      Text('9AM to 12PM  ',
                                          style: GoogleFonts.getFont(
                                            'Work Sans',
                                            color: const Color(0xFF2E5899),
                                            fontWeight: FontWeight.bold,
                                            fontSize: bodyfontSize,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                              _value == 1
                                  ? const ContactButtons()
                                  : const SizedBox(
                                      height: 8,
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), //CRL
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeOut,
                        // height: _value == 2 ? 145 : 48,
                        width: 155,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //AQUI INICIA
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: 2,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() => _value = 2);
                                          customerController.contactRange =
                                              '12PM to 5PM';
                                          customerController.contactByPhone =
                                              true;
                                          customerController.contactByEmail =
                                              true;
                                        },
                                        activeColor: Colors.red,
                                      ),
                                      Text('12PM to 5PM  ',
                                          style: GoogleFonts.getFont(
                                            'Work Sans',
                                            color: const Color(0xFF2E5899),
                                            fontWeight: FontWeight.bold,
                                            fontSize: bodyfontSize,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              _value == 2
                                  ? const ContactButtons()
                                  : const SizedBox(
                                      height: 8,
                                    )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 0),
                        curve: Curves.easeOut,
                        // height: _value == 3 ? 145 : 48,
                        width: 155,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: 3,
                                        groupValue: _value,
                                        onChanged: (value) {
                                          setState(() => _value = 3);
                                          customerController.contactRange =
                                              'Any time';
                                          customerController.contactByPhone =
                                              true;
                                          customerController.contactByEmail =
                                              true;
                                        },
                                        activeColor: Colors.red,
                                      ),
                                      Text('Any time',
                                          style: GoogleFonts.getFont(
                                            'Work Sans',
                                            color: const Color(0xFF2E5899),
                                            fontWeight: FontWeight.bold,
                                            fontSize: bodyfontSize,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              _value == 3
                                  ? const ContactButtons()
                                  : const SizedBox(
                                      height: 8,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          )

        //MOBILE VIEW
        : Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Select your preferred Time & Contact Method: ",
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: headerfontSize,
                      ),
                    ),
                  ),
                ],
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      curve: Curves.easeOut,
                      width: _value == 1 ? 260 : 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(3.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() => _value = 1);
                                    customerController.contactRange =
                                        '9AM to 12PM';
                                    customerController.contactByPhone = true;
                                    customerController.contactByEmail = true;
                                  },
                                  activeColor: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.8),
                                  child: Text('9AM to 12PM  ',
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontWeight: FontWeight.bold,
                                        fontSize: bodyfontSize,
                                      )),
                                ),
                              ],
                            ),
                            _value == 1
                                ? const FittedBox(
                                    fit: BoxFit.contain,
                                    child: ContactButtons(),
                                  )
                                : const SizedBox(
                                    width: 1,
                                  )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5), //CRL
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      curve: Curves.easeOut,
                      width: _value == 2 ? 260 : 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(3.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() => _value = 2);
                                    customerController.contactRange =
                                        '12PM to 5PM';
                                    customerController.contactByPhone = true;
                                    customerController.contactByEmail = true;
                                  },
                                  activeColor: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.8),
                                  child: Text('12PM to 5PM  ',
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontWeight: FontWeight.bold,
                                        fontSize: bodyfontSize,
                                      )),
                                ),
                              ],
                            ),
                            _value == 2
                                ? const FittedBox(
                                    fit: BoxFit.contain,
                                    child: ContactButtons(),
                                  )
                                : const SizedBox(
                                    width: 1,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      curve: Curves.easeOut,
                      width: _value == 3 ? 260 : 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.all(3.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 3,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() => _value = 3);
                                    customerController.contactRange =
                                        'Any time';
                                    customerController.contactByPhone = true;
                                    customerController.contactByEmail = true;
                                  },
                                  activeColor: Colors.red,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 1.8),
                                  child: Text('Any time  ',
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontWeight: FontWeight.bold,
                                        fontSize: bodyfontSize,
                                      )),
                                ),
                              ],
                            ),
                            _value == 3
                                ? const FittedBox(
                                    fit: BoxFit.contain,
                                    child: ContactButtons())
                                : const SizedBox(
                                    width: 1,
                                  )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5)
                  ],
                ),
              )
            ],
          );
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: const Color(0xFF2E5899),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: view,
      ),
    );
  }
}

// Widget rollSlides(BuildContext context) {
//   final customerController = Provider.of<CustomerInfoProvider>(context);

//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       ///PHONE CHECK HERE
//       RollingSwitch.icon(
//         initialState: true,
//         onChanged: (bool phstate) {
//           customerController.contactByPhone = phstate;
//         },
//         rollingInfoRight: const RollingIconInfo(
//           icon: Icons.phone,
//           iconColor: Color(0xFFd20030),
//           text: Text(
//             'Phone',
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//           backgroundColor: Color(0xFF2e5899),
//         ),
//         rollingInfoLeft: const RollingIconInfo(
//           icon: Icons.block,
//           text: Text(
//             'Phone',
//             style: TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//           backgroundColor: Color(0xFF616161),
//         ),
//       ),

//       ///
//       const Divider(
//         height: 1,
//         thickness: 1,
//         color: Color(0xFF8AA7D2),
//         indent: 2,
//         endIndent: 2,
//       ),

//       ///EMAIL CHECK HERE
//       RollingSwitch.icon(
//         initialState: true,
//         onChanged: (bool emstate) {
//           customerController.contactByEmail = emstate;
//         },
//         rollingInfoRight: const RollingIconInfo(
//           icon: (Icons.email),
//           iconColor: Color(0xFFd20030),
//           text: Text(
//             'Email',
//             style: TextStyle(color: Colors.white, fontSize: 12),
//           ),
//           backgroundColor: Color(0xFF2e5899),
//         ),
//         rollingInfoLeft: const RollingIconInfo(
//           icon: Icons.block,
//           text: Text(
//             'Email',
//             style: TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//           backgroundColor: Color(0xFF616161),
//         ),
//       ),
//     ],
//   );
// }
