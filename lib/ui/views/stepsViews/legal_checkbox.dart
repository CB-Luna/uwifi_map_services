import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_ssn_acp_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class LegalCheckbox extends StatefulWidget {
  const LegalCheckbox({Key? key}) : super(key: key);

  @override
  LegalCheckboxState createState() => LegalCheckboxState();
}

class LegalCheckboxState extends State<LegalCheckbox> {
  bool emailCheckbox = true;
  bool smsCheckbox = true;

  @override
  Widget build(BuildContext context) {
    final customerSSNACPController =
        Provider.of<CustomerSSNACPProvider>(context, listen: false);
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * (isMobile ? 0.8 : 0.4),
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'I would like to receive promotional messages from U-wifi by E-mail. You can unsubscribe at any time.',
                    style: GoogleFonts.workSans(
                    fontSize: 15,
                    color: colorInversePrimary,
                    fontWeight: FontWeight.normal)),
                  ),
                ),
              ),
              Checkbox(
              side: const BorderSide(
                  color: colorBgWhite,
                  width: 2.0
                ),
                value: emailCheckbox,
                activeColor: colorBgWhite,
                onChanged: (emailyes) {
                  setState(() {
                    emailCheckbox = emailyes!;
                  });
                  customerSSNACPController.promoInfobyEmail = emailCheckbox;
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * (isMobile ? 0.8 : 0.4),
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'I would like to receive promotional messages from U-wifi by SMS.\n*Message and data rates may apply to receiving these messages.\n*Reply with STOP at any time to opt-out from future messages.',
                    style: GoogleFonts.workSans(
                    fontSize: 15,
                    color: colorInversePrimary,
                    fontWeight: FontWeight.normal)),
                  ),
                ),
              ),
              Checkbox(
                side: const BorderSide(
                  color: colorBgWhite,
                  width: 2.0
                ),
                value: smsCheckbox,
                activeColor: colorBgWhite,
                onChanged: (smsyes) {
                  setState(() {
                    smsCheckbox = smsyes!;
                  });
                  customerSSNACPController.promoInfoibySMS = smsCheckbox;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}