import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

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
    final controller = Provider.of<CustomerShippingInfo>(context);
    final customerInfoController = Provider.of<CustomerInfoProvider>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return Column(
      children: [
        Container(
              width: 1400,
              height: 465,
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
                                    value: controller.sameAsPD,
                                    onChanged: (bool? value) {
                                      controller.changeValuesShippingDetails();
                                    },
                                  ),
                                ],
                              ),
                            ),
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
                            Flexible(
                              flex: 1,
                              child: CreditCardWidget(
                                height: 200,
                                width: 400,
                                cardBgColor: colorSecondary,
                                cardNumber: controller.number.text,
                                expiryDate: controller.date.text,
                                cardHolderName: controller.cardName.text,
                                cvvCode: controller.cvv.text,
                                isHolderNameVisible: true,
                                showBackView: isCvvFocused,
                                onCreditCardWidgetChange:
                                    (CreditCardBrand creditCardBrand) {
                                    },
                                glassmorphismConfig: Glassmorphism(
                                  blurX: 8.0, 
                                  blurY: 16.0, 
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        colorSecondary,
                                        colorSecondary.withAlpha(200),
                                      ],
                                      stops: const <double>[
                                        0.3,
                                        0,
                                      ],
                                    )),
                                enableFloatingCard: true,
                                floatingConfig: const FloatingConfig(
                                  isGlareEnabled: true,
                                  isShadowEnabled: true,
                                  shadowConfig: FloatingShadowConfig(),
                                ),
                                ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Form(
                                    key: customerInfoController.formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      /// VARIABLE STORAGE
                                                      controller: controller.parsedAddress1PD,
                                                                  
                                                      ///VALIDATION TRIGGER
                                                      // initialValue: dir,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      obscureText: false,
                                                      keyboardType: TextInputType.phone,
                                                      decoration: CustomInputs().formInputDecoration(
                                                          label: 'Address Line 1*',
                                                          icon: Icons.house_outlined,
                                                          maxHeight: 55),
                                                      style: const TextStyle(
                                                        color: colorPrimaryDark,
                                                      ),
                                                      validator: (value) {
                                                        if (value == null || value.isEmpty) {
                                                          return 'Please enter a valid address';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      /// VARIABLE STORAGE
                                                      controller: controller.parsedAddress2PD,
                                                                  
                                                      ///VALIDATION TRIGGER
                                                      // initialValue: dir,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      obscureText: false,
                                                      keyboardType: TextInputType.phone,
                                                      decoration: CustomInputs().formInputDecoration(
                                                          label: 'Address Line 2',
                                                          icon: Icons.house_outlined,
                                                          maxHeight: 55),
                                                      style: const TextStyle(
                                                        color: colorPrimaryDark,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Expanded(
                                                    child: TextFormField(
                                                      /// VARIABLE STORAGE
                                                      controller: controller.parsedZipcodePD,
                                                                  
                                                      ///VALIDATION TRIGGER
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      obscureText: false,
                                                      keyboardType: TextInputType.number,
                                                      decoration: CustomInputs().formInputDecoration(
                                                          label: 'Zipcode*',
                                                          icon: Icons.other_houses_outlined,
                                                          maxHeight: 55),
                                                                  
                                                      validator: (value) {
                                                        return (phoneCharacters.hasMatch(value ?? '') &&
                                                                value?.length == 5)
                                                            ? null
                                                            : 'Please enter a valid Zipcode';
                                                      },
                                                      style: const TextStyle(
                                                        color: colorPrimaryDark,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      /// VARIABLE STORAGE
                                                      controller: controller.parsedCityPD,
                                                                  
                                                      ///VALIDATION TRIGGER
                                                      // initialValue: dir,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      obscureText: false,
                                                      keyboardType: TextInputType.phone,
                                                      decoration: CustomInputs().formInputDecoration(
                                                          label: 'City*',
                                                          icon: Icons.house_outlined,
                                                          maxHeight: 55),
                                                      style: const TextStyle(
                                                        color: colorPrimaryDark,
                                                      ),
                                                      validator: (value) {
                                                        return validCharacters.hasMatch(value ?? '')
                                                            ? null
                                                            : 'Please enter a City';
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: TextFormField(
                                                      /// VARIABLE STORAGE
                                                      controller: controller.parsedStatePD,
                                                                  
                                                      ///VALIDATION TRIGGER
                                                      // initialValue: dir,
                                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                                      obscureText: false,
                                                      keyboardType: TextInputType.phone,
                                                      decoration: CustomInputs().formInputDecoration(
                                                          label: 'State*',
                                                          icon: Icons.house_outlined,
                                                          maxHeight: 55),
                                                      style: const TextStyle(
                                                        color: colorPrimaryDark,
                                                      ),
                                                      validator: (value) {
                                                        return validCharacters.hasMatch(value ?? '')
                                                            ? null
                                                            : 'Please enter a State';
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      )),
                                  CreditCardForm(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    formKey: controller.formKeyCC,
                                    obscureCvv: true,
                                    cardNumber: controller.number.text,
                                    expiryDate: controller.date.text,
                                    cardHolderName: controller.cardName.text,
                                    cvvCode: controller.cvv.text,
                                    isHolderNameVisible: true,
                                    isCardNumberVisible: true,
                                    isExpiryDateVisible: true,
                                    numberValidationMessage: "Please enter a valid number",
                                    dateValidationMessage: "Please enter a valid date",
                                    cvvValidationMessage: "Please enter a valid CVV",
                                    inputConfiguration: InputConfiguration(
                                      cardNumberDecoration: CustomInputs()
                                    .formInputDecoration(
                                        label: 'Number*',
                                        icon: Icons.credit_card_outlined,
                                        maxHeight: 55),
                                    expiryDateDecoration: CustomInputs()
                                    .formInputDecoration(
                                        label: 'Expiry Date*',
                                        icon: Icons.calendar_month_outlined,
                                        maxHeight: 55),
                                    cvvCodeDecoration: CustomInputs()
                                    .formInputDecoration(
                                        label: 'CVV*',
                                        icon: Icons.lock_outlined,
                                        maxHeight: 55),
                                    cardHolderDecoration: CustomInputs()
                                    .formInputDecoration(
                                        label: 'Card Holder*',
                                        icon: Icons.person,
                                        maxHeight: 55),
                                    ),
                                    onCreditCardModelChange: (creditCardModel) {
                                        controller.onCreditCardModelChange(creditCardModel);
                                    }, 
                                  ),
                                ],
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
