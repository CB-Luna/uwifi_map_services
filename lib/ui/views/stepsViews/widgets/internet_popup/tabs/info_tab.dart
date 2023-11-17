import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../expanded_widget.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final bool mobile = size.width < 600 ? true : false;
    const double mobileTitle = 12;
    const double mobileText = 10.5;
    double boxPadding = mobile ? 20.0 : 30.0;

    return Container(
        decoration: BoxDecoration(
          color: mobile ? null : Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        margin: EdgeInsets.symmetric(horizontal: mobile ? 0.0 : 25.0),
        child: Padding(
            padding: EdgeInsets.all(mobile ? 0.0 : boxPadding),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              mobile
                  ? ExpandedWidget(
                      boxPadding: boxPadding,
                      title: "A Wireless Router will be required.",
                      text:
                          'You can purchase a Wi-Fi router starting at about \$100 or you can purchase a third-party Wireless Router on your own. \n \nMore information will be provided to you when one of our RTA customer representatives gets in contact with you.')
                  : Column(mainAxisSize: MainAxisSize.max, children: [
                      RichText(
                        text: TextSpan(children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(MdiIcons.alertCircleOutline,
                                  size: 16.0, color: Color(0xFF8AA7D2)),
                            ),
                          ),
                          TextSpan(
                            text: 'A Wireless Router will be required.',
                            style: GoogleFonts.workSans(
                                fontSize: mobile ? mobileTitle : 16,
                                color: const Color(0xFF2e5899),
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 15),
                      Text(
                          'You can purchase a Wi-Fi router starting at about \$100 or you can purchase a third-party Wireless Router on your own.',
                          style: GoogleFonts.workSans(
                              height: 1.5,
                              fontSize: mobile ? mobileText : 12,
                              color: const Color(0xFF2e5899),
                              fontWeight: FontWeight.normal,
                              letterSpacing: -0.2)),
                      const SizedBox(height: 15),
                      Text(
                          'More information will be provided to you when one of our RTA customer representatives gets in contact with you.',
                          style: GoogleFonts.workSans(
                              height: 1.5,
                              fontSize: mobile ? mobileText : 12,
                              color: const Color(0xFFd20030),
                              fontWeight: FontWeight.normal,
                              letterSpacing: -0.2)),
                      const SizedBox(height: 25),
                    ]),
              Image.asset('images/router.png', height: mobile ? 80 : 125),
            ])));
  }
}
