import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';

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
    return SizedBox(
      width: 1400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
            width: 5,
          ),
          CheckboxListTile(
            value: emailCheckbox,
            onChanged: (emailyes) {
              setState(() {
                emailCheckbox = emailyes!;
              });
              customerController.promoInfobyEmail = emailCheckbox;
            },
            subtitle: Text(
              'I would like to receive promotional messages from UWIFI by E-mail. You can unsubscribe at any time.',
              style: bodyStyle(context),
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
            subtitle: Text(
                'I would like to receive promotional messages from UWIFI by SMS.\n\n*Message and data rates may apply to receiving these messages.\n\n*Reply with STOP at any time to opt-out from future messages.',
                style: bodyStyle(context)),
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

class AckCheckbox extends StatefulWidget {
  const AckCheckbox({Key? key}) : super(key: key);

  @override
  AckCheckboxState createState() => AckCheckboxState();
}

bool ackCheck = false;

class AckCheckboxState extends State<AckCheckbox> {
  @override
  Widget build(BuildContext context) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? bodyfontSize = lerpDouble(10, 18, (appwidth - 500) / maxAppWidth);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
                value: ackCheck,
                activeColor: const Color(0xFFDF1515),
                onChanged: (acked) {
                  setState(() {
                    ackCheck = acked!;
                  });
                }),
            Text(
              respSize.width > 420
                  ? 'I acknowledge this information has been provided to me'
                  : 'I acknowledge this information has\nbeen provided to me',
              style: GoogleFonts.getFont(
                'Work Sans',
                color: const Color(0xFFD20030),
                fontSize: bodyfontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 350,
          height: 30,
        ),
        if (ackCheck == true) ...[
        ] else ...[
        ],
        const Padding(padding: EdgeInsets.only(bottom: 12.0))
      ],
    );
  }
}
