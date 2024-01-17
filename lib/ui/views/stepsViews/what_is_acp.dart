import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class WhatIsACP extends StatefulWidget {
  const WhatIsACP({Key? key}) : super(key: key);

  @override
  State<WhatIsACP> createState() => _WhatIsACPState();
}

class _WhatIsACPState extends State<WhatIsACP> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return Column(
      children: [
        Container(
              width: 1400,
              height: 210,
              decoration: BoxDecoration(
                color: colorInversePrimary,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    spreadRadius: -5,
                    color: colorBgB,
                    offset: Offset(0, 15),
                  )
                ],
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                  children: [
                    Container(
                      width: 1400,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: colorPrimary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.credit_card_outlined,
                                      color: colorInversePrimary,
                                      size: isMobile ? 25 : 40,
                                    ),
                                  ),
                                  Text(
                                    'What is ACP?',
                                    style: TextStyle(
                                      color: colorInversePrimary,
                                      fontSize: isMobile ? 14 : 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  'For more information: ',
                                  style: GoogleFonts.workSans(
                                  fontSize: isMobile ? 12 : 18,
                                  color: colorInversePrimary,
                                  fontWeight: FontWeight.normal)),
                                GestureDetector(
                                  onTap: () async {
                                    // Abrir el enlace cuando se toque
                                    await launchUrl(Uri.parse(
                                    'https://www.fcc.gov/acp'));
                                  },
                                  child: Text(
                                    'https://www.fcc.gov/acp',
                                    style: TextStyle(
                                      color: colorInversePrimary,
                                      fontSize: isMobile ? 12 : 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),)
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "The Affordable Connectivity Program is an FCC benefit initiative aimed at making broadband more affordable for households, ensuring access for work, education, healthcare, and other needs. The program offers a discount of up to \$30 per month for internet service, with a higher allowance of up to \$75 per month for households in qualifying Tribal lands.",
                                  style: GoogleFonts.workSans(
                                  fontSize: isMobile ? 12 : 18,
                                  color: colorPrimary,
                                  fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
      ],
    );
  }
}
