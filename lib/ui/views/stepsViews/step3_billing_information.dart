import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_credit_card.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_form_credit_card.dart';

class Step3BillingInformationForm extends StatefulWidget {
  const Step3BillingInformationForm({Key? key}) : super(key: key);

  @override
  State<Step3BillingInformationForm> createState() => _Step3BillingInformationFormState();
}

class _Step3BillingInformationFormState extends State<Step3BillingInformationForm> {
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
        Container(
              width: 1400,
              height: isMobile ? 700 : 465,
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
                                    'Step 3: Billing Information',
                                    style: TextStyle(
                                      color: colorInversePrimary,
                                      fontSize: isMobile ? 14 : 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Same as Shipping Details',
                                    style: GoogleFonts.workSans(
                                    fontSize: isMobile ? 12 : 18,
                                    color: colorInversePrimary,
                                    fontWeight: FontWeight.normal)),
                                  Checkbox(
                                    side: const BorderSide(
                                      color: colorBgWhite,
                                      width: 2.0
                                    ),
                                    value: customerPDSDCCController.sameAsPD,
                                    onChanged: (bool? value) {
                                      customerPDSDCCController.changeValuesShippingDetails();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: isMobile ? const Column(
                        children: [
                          CustomCreditCard(),
                          CustomFormCreditCard(),
                        ],
                      )
                      :
                      const Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: CustomCreditCard()
                          ),
                          Flexible(
                            flex: 2,
                            child: CustomFormCreditCard()
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
      ],
    );
  }
}
