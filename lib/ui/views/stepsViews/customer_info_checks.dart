import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class PromoCheckbox extends StatefulWidget {
  const PromoCheckbox({Key? key}) : super(key: key);

  @override
  PromoCheckboxState createState() => PromoCheckboxState();
}

class PromoCheckboxState extends State<PromoCheckbox> {
  bool emailCheckbox = true;
  bool smsCheckbox = true;

  @override
  Widget build(BuildContext context) {
    final customerController =
        Provider.of<CustomerInfoProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  'I would like to receive promotional messages from UWIFI by E-mail. You can unsubscribe at any time.',
                  style: GoogleFonts.workSans(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight.normal)),
              ),
              Checkbox(
                side: const BorderSide(
                  color: colorPrimary,
                  width: 2.0
                ),
                value: emailCheckbox,
                onChanged: (emailyes) {
                  setState(() {
                    emailCheckbox = emailyes!;
                  });
                  customerController.promoInfobyEmail = emailCheckbox;
                },
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  'I would like to receive promotional messages from UWIFI by SMS.\n\n*Message and data rates may apply to receiving these messages.\n\n*Reply with STOP at any time to opt-out from future messages.',
                  style: GoogleFonts.workSans(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight.normal)),
              ),
              Checkbox(
                side: const BorderSide(
                  color: colorPrimary,
                  width: 2.0
                ),
                value: smsCheckbox,
                onChanged: (smsyes) {
                  setState(() {
                    smsCheckbox = smsyes!;
                  });
                  customerController.promoInfoibySMS = smsCheckbox;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}