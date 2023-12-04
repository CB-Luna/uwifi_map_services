import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
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
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            value: emailCheckbox,
            onChanged: (emailyes) {
              setState(() {
                emailCheckbox = emailyes!;
              });
              customerController.promoInfobyEmail = emailCheckbox;
            },
            title: Text(
              'I would like to receive promotional messages from UWIFI by E-mail. You can unsubscribe at any time.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1,
                color: colorPrimary,
                fontWeight: FontWeight.w300,
              ),
            ),
            activeColor: colorsTheme(context).tertiary,
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          ),
          CheckboxListTile(
            value: smsCheckbox,
            onChanged: (smsyes) {
              setState(() {
                smsCheckbox = smsyes!;
              });
              customerController.promoInfoibySMS = smsCheckbox;
            },
            title: Text(
                'I would like to receive promotional messages from UWIFI by SMS.\n\n*Message and data rates may apply to receiving these messages.\n\n*Reply with STOP at any time to opt-out from future messages.',
                style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1,
                color: colorPrimary,
                fontWeight: FontWeight.w300,
              ),),
            activeColor: colorsTheme(context).tertiary,
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
          ),
         
        ],
      ),
    );
  }
}