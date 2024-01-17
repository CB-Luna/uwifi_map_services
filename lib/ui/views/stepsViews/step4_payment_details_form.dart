import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_credit_card.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_form_credit_card.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/form_payment_address.dart';

class Step4PaymentDetailsForm extends StatefulWidget {
  const Step4PaymentDetailsForm({Key? key}) : super(key: key);

  @override
  State<Step4PaymentDetailsForm> createState() => _Step4PaymentDetailsFormState();
}

class _Step4PaymentDetailsFormState extends State<Step4PaymentDetailsForm> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final customerPDSDCCController = Provider.of<CustomerPDSDCCProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        Icons.credit_card_outlined,
                        color: colorInversePrimary,
                        size: isMobile ? 25 : 40,
                      ),
                    ),
                    Text(
                      'Payment Details',
                      style: TextStyle(
                        color: colorInversePrimary,
                        fontSize: isMobile ? 18 : 26,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: isMobile ? const Column(
            children: [
              CustomCreditCard(),
              CustomFormCreditCard(),
            ],
          )
          :
          Column(
            children: [
              const Row(
                children: [
                  Flexible(
                    child: CustomCreditCard()
                  ),
                  Flexible(
                    child: CustomFormCreditCard()
                  ),
                ],
              ),
              Visibility(
                visible: !customerPDSDCCController.sameAsSD,
                child: const FormPaymentAddress(),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  'Same Billing as Shipping Address',
                  style: GoogleFonts.workSans(
                  fontSize: isMobile ? 12 : 16,
                  color: colorInversePrimary,
                  fontWeight: FontWeight.normal)),
              ),
              Flexible(
                flex: 1,
                child: Checkbox(
                  side: const BorderSide(
                    color: colorBgWhite,
                    width: 2.0
                  ),
                  activeColor: colorBgWhite,
                  value: customerPDSDCCController.sameAsSD,
                  onChanged: (bool? value) {
                    customerPDSDCCController.changeValuesBillingDetails();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
