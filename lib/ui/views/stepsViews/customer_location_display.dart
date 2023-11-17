import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'customer_info_checks.dart';
import 'package:uwifi_map_services/classes/popup.dart';

class CustomerLocationDisplay extends StatelessWidget with Popup {
  final String street;
  final String city;
  final String state;
  final String zcode;
  CustomerLocationDisplay({
    Key? key,
    required this.street,
    required this.city,
    required this.state,
    required this.zcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerInfo = Provider.of<CustomerInfoProvider>(context);
    final bool isRep = customerInfo.customerInfo.customerRep != '';

    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isRep)
            Container(
              height: 450,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: -5,
                    color: Color(0x506FA5DB),
                    offset: Offset(0, 15),
                  )
                ],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'images/pointer.png',
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isRep ? 'Customer Address' : 'Your address',
                          style: h2Style(context),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFF8AA7D2),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.person_pin_circle_outlined,
                                  color: Color(0xFF8AA7D2),
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Street',
                                  style: GoogleFonts.getFont('Work Sans',
                                      color: const Color(0xFF2E5899),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.25),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1, 0),
                                    child: Text(
                                      street,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFD8E3F2),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_city_outlined,
                                  color: Color(0xFF8AA7D2),
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'City',
                                  style: GoogleFonts.getFont('Work Sans',
                                      color: const Color(0xFF2E5899),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.25),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1, 0),
                                    child: Text(
                                      // 'Carlsbad',
                                      city,
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFD8E3F2),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.outlined_flag,
                                  color: Color(0xFF8AA7D2),
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'State',
                                  style: GoogleFonts.getFont('Work Sans',
                                      color: const Color(0xFF2E5899),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.25),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1, 0),
                                    child: Text(
                                      state,
                                      // 'California',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color(0xFFD8E3F2),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.store_outlined,
                                  color: Color(0xFF8AA7D2),
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Zip Code',
                                  style: GoogleFonts.getFont('Work Sans',
                                      color: const Color(0xFF2E5899),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      letterSpacing: -0.25),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: const AlignmentDirectional(1, 0),
                                    child: Text(
                                      zcode,
                                      // 'SampleZip',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.getFont(
                                        'Work Sans',
                                        color: const Color(0xFF2E5899),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: isRep ? 25 : 0),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white.withOpacity(0.5),
            ),
            child: const PromoCheckbox(),
          ),
        ],
      ),
    );
  }
}
