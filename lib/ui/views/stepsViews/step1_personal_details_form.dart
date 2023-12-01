import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class Step1PersonalDetailsForm extends StatelessWidget {
  final String dir;
  const Step1PersonalDetailsForm({Key? key, required this.dir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CustomerShippingInfo>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          /// VARIABLE STORAGE
                                          controller: controller.parsedFNamePD,

                                          ///VALIDATION TRIGGER
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
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
          height: 300,
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
                Row(
                  children: [
                    CreditCardWidget(
                      width: 400,
                      height: 160,
                      cardNumber: "12345678979",
                       expiryDate: "22/15",
                        cardHolderName: "Luis Fierro", 
                        cvvCode: "125", 
                        showBackView: false, 
                        onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {}),
                    // CreditCardForm(
                    //   cardNumber: controller.number,
                    //      expiryDate: controller.date,
                    //       cardHolderName: controller.cardName, 
                    //       cvvCode: controller.ccv, 
                    //   onCreditCardModelChange: onCreditCardModelChange, 
                    //   formKey: formKey)
                  ],
                )
              ]),
        ),
      ],
    );
    
  }
  
}

