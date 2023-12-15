import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_drop_down.dart';

import '../../../../providers/customer_pd_sd_cc_provider.dart';

class CustomFormCreditCard extends StatelessWidget {
  const CustomFormCreditCard({Key? key}) : super(key: key);

  //El slider de extensiones sigue pendiente
  @override
  Widget build(BuildContext context) {
    final customerPDSDCCController = Provider.of<CustomerPDSDCCProvider>(context);
    final customerInfoController = Provider.of<CustomerInfoProvider>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final zipcodeCharacters = RegExp(r'^[0-9\-() ]+$');
    var zipcodeFormat = MaskTextInputFormatter(
      mask: '######',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return Column(
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
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: customerPDSDCCController.parsedAddress1BD,
                                        
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
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: customerPDSDCCController.parsedAddress2BD,
                                        
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
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: customerPDSDCCController.parsedZipcodeBD,
                                        
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Zipcode*',
                                icon: Icons.other_houses_outlined,
                                maxHeight: 55),
                                        
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              zipcodeFormat
                            ],
                            validator: (value) {
                              return (zipcodeCharacters
                                          .hasMatch(value ?? '') &&
                                      value?.length == 5)
                                  ? null
                                  : 'Please enter a valid zipcode';
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
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: customerPDSDCCController.parsedCityBD,
                                        
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
                        Flexible(
                          child: CustomDropDown(
                            validator: (value) {
                              return (value == "" || value == null)
                                ? 'Please select a state.'
                                : null;
                            },
                            maxHeight: 55,
                            icon: Icons.house_outlined,
                            label: 'State*',
                            width: double.infinity,
                            list: customerPDSDCCController.stateCodes.values.toList(),
                            dropdownValue: customerPDSDCCController.parsedStateBD.text == "" ? null : 
                              customerPDSDCCController.parsedStateBD.text,
                            onChanged: (newState) {
                              if (newState == null) return;
                              customerPDSDCCController.selectStateUpdateBD(newState);
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
            )),
        CreditCardForm(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          formKey: customerPDSDCCController.formKeyCC,
          obscureCvv: true,
          cardNumber: customerPDSDCCController.number.text,
          expiryDate:customerPDSDCCController.date.text,
          cardHolderName:customerPDSDCCController.cardName.text,
          cvvCode:customerPDSDCCController.cvv.text,
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
              customerPDSDCCController.onCreditCardModelChange(creditCardModel);
          }, 
        ),
      ],
    );
  }

}
