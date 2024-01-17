import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

import '../../../../providers/customer_pd_sd_cc_provider.dart';

class CustomFormCreditCard extends StatelessWidget {
  const CustomFormCreditCard({Key? key}) : super(key: key);

  //El slider de extensiones sigue pendiente
  @override
  Widget build(BuildContext context) {
    final customerPDSDCCController = Provider.of<CustomerPDSDCCProvider>(context);
    final placesBD = customerPDSDCCController.placesBD ?? [];
    if (placesBD.isNotEmpty) {
      customerPDSDCCController.hasSuggestionsBD = true;
    } else {
      customerPDSDCCController.hasSuggestionsBD = false;
    }

    return CreditCardForm(
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
      cardNumberTextStyle: const TextStyle(
        color: colorBgWhite
      ),
      expiryDateDecoration: CustomInputs()
      .formInputDecoration(
          label: 'Expiry Date*',
          icon: Icons.calendar_month_outlined,
          maxHeight: 55),
      expiryDateTextStyle: const TextStyle(
        color: colorBgWhite
      ),
      cvvCodeDecoration: CustomInputs()
      .formInputDecoration(
          label: 'CVV*',
          icon: Icons.lock_outlined,
          maxHeight: 55),
      cvvCodeTextStyle: const TextStyle(
        color: colorBgWhite
      ),
      cardHolderDecoration: CustomInputs()
      .formInputDecoration(
          label: 'Card Holder*',
          icon: Icons.person,
          maxHeight: 55),
      cardHolderTextStyle: const TextStyle(
        color: colorBgWhite
      ),
      ),
      onCreditCardModelChange: (creditCardModel) {
          customerPDSDCCController.onCreditCardModelChange(creditCardModel);
      }, 
    );
  }

}
