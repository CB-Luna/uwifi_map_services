import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class Step1PersonalDetailsForm extends StatefulWidget {
  final String dir;
  const Step1PersonalDetailsForm({Key? key, required this.dir})
      : super(key: key);

  @override
  State<Step1PersonalDetailsForm> createState() => _Step1PersonalDetailsFormState();
}

class _Step1PersonalDetailsFormState extends State<Step1PersonalDetailsForm> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CustomerShippingInfo>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // final zcode = widget.zipcode.toString();
    var phoneFormat = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    

    return Column(
      children: [
        Container(
          width: 1400,
          height: 330,
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
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1400,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: colorPrimary,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_history_outlined,
                        color: colorInversePrimary,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Step 1: Personal Details',
                        style: TextStyle(
                          color: colorInversePrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const Divider(
              //   height: 1,
              //   thickness: 1.5,
              //   color: colorPrimaryDark,
              // ),
              Flexible(
                child: Form(
                    key: controller.formKeyPD,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    /// VARIABLE STORAGE
                                    controller: controller.parsedFNamePD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    autocorrect: false,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'First Name*',
                                            icon: Icons.person_outlined,
                                            maxHeight: 60),

                                    validator: (value) {
                                      return validCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Please enter your name';
                                    },
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    /// VARIABLE STORAGE
                                    controller: controller.parsedLNamePD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    autocorrect: false,
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'Last Name*',
                                            icon: Icons.person_outlined,
                                            maxHeight: 60),

                                    validator: (value) {
                                      return validCharacters
                                              .hasMatch(value ?? '')
                                          ? null
                                          : 'Please enter your name';
                                    },
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    /// VARIABLE STORAGE
                                    controller: controller.parsedPhonePD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    keyboardType: TextInputType.phone,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'Phone Number*',
                                            icon: Icons.phone_outlined,
                                            maxHeight: 60),

                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(14),
                                      phoneFormat
                                    ],
                                    validator: (value) {
                                      return (phoneCharacters
                                                  .hasMatch(value ?? '') &&
                                              value?.length == 14)
                                          ? null
                                          : 'Please enter a valid phone number';
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
                                    readOnly: true,
                                    enabled: false,

                                    /// VARIABLE STORAGE
                                    controller: controller.parsedAddress1PD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'Address Line 1*',
                                            icon: Icons.house_outlined,
                                            maxHeight: 60),
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    keyboardType: TextInputType.streetAddress,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'Address Line 2',
                                            icon: Icons.house_outlined,
                                            maxHeight: 60),
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    enabled: false,

                                    /// VARIABLE STORAGE
                                    controller: controller.parsedZipcodePD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'Zipcode*',
                                            icon: Icons.mail_outlined,
                                            maxHeight: 60),
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
                                    readOnly: true,
                                    enabled: false,

                                    /// VARIABLE STORAGE
                                    controller: controller.parsedCityPD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'City*',
                                            icon: Icons.house_outlined,
                                            maxHeight: 60),
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    readOnly: true,
                                    enabled: false,

                                    /// VARIABLE STORAGE
                                    controller: controller.parsedStatePD,

                                    ///VALIDATION TRIGGER
                                    // initialValue: dir,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'State*',
                                            icon: Icons.house_outlined,
                                            maxHeight: 60),
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextFormField(
                                    /// VARIABLE STORAGE
                                    controller: controller.parsedEmailPD,

                                    ///VALIDATION TRIGGER
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    obscureText: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: CustomInputs()
                                        .formInputDecoration(
                                            label: 'E-mail Address*',
                                            icon: Icons.mail_outlined,
                                            maxHeight: 60),

                                    validator: (value) {
                                      String pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regExp = RegExp(pattern);
                                      return regExp.hasMatch(value ?? '')
                                          ? null
                                          : 'Please enter a valid e-mail address';
                                    },
                                    style: const TextStyle(
                                      color: colorPrimaryDark,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          width: 1400,
          height: 380,
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
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1400,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: colorPrimary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_card_outlined,
                          color: colorInversePrimary,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Step 2: Card Information',
                          style: TextStyle(
                            color: colorInversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //  (MediaQuery.of(context).size.width > 1130) ?
                Row(
                  children: [
                    //Tarjeta
                    CreditCardWidget(
                        width: 400,
                        height: 200,
                        key: formKey,
                        enableFloatingCard: true,
                        cardBgColor: colorPrimary,
                        cardNumber: number.text,
                        expiryDate: date.text,
                        cardHolderName: cardName.text,
                        cvvCode: ccv.text,
                        isHolderNameVisible: true,
                        showBackView: isCvvFocused,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {}),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          cardNumber: number.text,
                          expiryDate: date.text,
                          cardHolderName: cardName.text,
                          cvvCode: ccv.text,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          inputConfiguration: InputConfiguration(
                            cardNumberDecoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'Number*',
                                    icon: Icons.credit_card_outlined,
                                    maxHeight: 60),
                            expiryDateDecoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'Expiry Date*',
                                    icon: Icons.calendar_month_outlined,
                                    maxHeight: 60),
                            cvvCodeDecoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'CVV**',
                                    icon: Icons.lock_outlined,
                                    maxHeight: 60),
                            cardHolderDecoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'Card Holder*',
                                    icon: Icons.person,
                                    maxHeight: 60),
                          ),
                          onCreditCardModelChange: (creditCardModel) {
                            setState(() {
                              number.text =
                                  creditCardModel.cardNumber;
                              date.text = creditCardModel.expiryDate;
                              cardName.text =
                                  creditCardModel.cardHolderName;
                              ccv.text = creditCardModel.cvvCode;
                              isCvvFocused =
                                  creditCardModel.isCvvFocused;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                )
                // : Column(
                //   children: [
                //     CreditCardWidget(
                //         width: 400,
                //         height: 200,
                //         key: formKey,
                //         enableFloatingCard: true,
                //         cardBgColor: colorPrimary,
                //         cardNumber: number.text,
                //         expiryDate: date.text,
                //         cardHolderName: cardName.text,
                //         cvvCode: ccv.text,
                //         isHolderNameVisible: true,
                //         showBackView: isCvvFocused,
                //         onCreditCardWidgetChange:
                //             (CreditCardBrand creditCardBrand) {}),
                //     Expanded(
                //       child: SingleChildScrollView(
                //         child: CreditCardForm(
                //           formKey: formKey,
                //           obscureCvv: true,
                //           cardNumber: number.text,
                //           expiryDate: date.text,
                //           cardHolderName: cardName.text,
                //           cvvCode: ccv.text,
                //           isHolderNameVisible: true,
                //           isCardNumberVisible: true,
                //           isExpiryDateVisible: true,
                //           inputConfiguration: InputConfiguration(
                //             cardNumberDecoration: CustomInputs()
                //                 .formInputDecoration(
                //                     label: 'Number*',
                //                     icon: Icons.credit_card_outlined,
                //                     maxHeight: 60),
                //             expiryDateDecoration: CustomInputs()
                //                 .formInputDecoration(
                //                     label: 'Expiry Date*',
                //                     icon: Icons.calendar_month_outlined,
                //                     maxHeight: 60),
                //             cvvCodeDecoration: CustomInputs()
                //                 .formInputDecoration(
                //                     label: 'CVV**',
                //                     icon: Icons.lock_outlined,
                //                     maxHeight: 60),
                //             cardHolderDecoration: CustomInputs()
                //                 .formInputDecoration(
                //                     label: 'Card Holder*',
                //                     icon: Icons.person,
                //                     maxHeight: 60),
                //           ),
                //           onCreditCardModelChange: (creditCardModel) {
                //             setState(() {
                //               number.text =
                //                   creditCardModel.cardNumber;
                //               date.text = creditCardModel.expiryDate;
                //               cardName.text =
                //                   creditCardModel.cardHolderName;
                //               ccv.text = creditCardModel.cvvCode;
                //               isCvvFocused =
                //                   creditCardModel.isCvvFocused;
                //             });
                //           },
                //         ),
                //       ),
                //     )
                //   ],
                // ),
              ]),
        ),
      ],
    );
  }
}
