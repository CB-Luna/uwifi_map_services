import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/legal_checkbox.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step1_acp_ssn_form.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step2_personal_details_form.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step3_shipping_details_form.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step4_payment_details_form.dart';

class FullFormWidget extends StatefulWidget {
  const FullFormWidget({Key? key}) : super(key: key);

  @override
  State<FullFormWidget> createState() => _FullFormWidgetState();
}

class _FullFormWidgetState extends State<FullFormWidget> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          Container(
            width:  MediaQuery.of(context).size.width * (isMobile ? 0.9 : 0.4),
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.32, -0.95),
                end: Alignment(0.32, 0.95),
                colors: [colorPrimaryLight, colorPrimaryDark],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
               children: [
                Step2PersonalDetailsForm(),
                Step3ShippingDetailsForm(),
                Step4PaymentDetailsForm(),
                LegalCheckbox()
               ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
