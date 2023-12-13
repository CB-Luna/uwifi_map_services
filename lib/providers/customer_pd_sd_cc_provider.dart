

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_maps/google_maps.dart';

class CustomerPDSDCCProvider with ChangeNotifier {
  //Bandera Checkbox SD same as PD
  bool sameAsPD = false;

  // Personal Details and Shipping Details
  GlobalKey<FormState> formKeyPD = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyCC = GlobalKey<FormState>();
  final TextEditingController parsedFNamePD = TextEditingController(text: "");
  final TextEditingController parsedLNamePD = TextEditingController(text: "");
  final TextEditingController parsedPhonePD = TextEditingController(text: "");
  final TextEditingController parsedEmailPD = TextEditingController(text: "");
  final TextEditingController parsedAddress1SD = TextEditingController(text: "");
  final TextEditingController parsedAddress2SD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeSD = TextEditingController(text: "");
  final TextEditingController parsedCitySD = TextEditingController(text: "");
  final TextEditingController parsedStateSD = TextEditingController(text: "");

  LatLng? locatizationPDSD;
  

  // Billing Details

  final TextEditingController parsedAddress1BD = TextEditingController(text: "");
  final TextEditingController parsedAddress2BD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeBD = TextEditingController(text: "");
  final TextEditingController parsedCityBD = TextEditingController(text: "");
  final TextEditingController parsedStateBD = TextEditingController(text: "");

  //Card Variables
  TextEditingController number = TextEditingController(text:"");
  TextEditingController cvv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    number.text = creditCardModel.cardNumber;
    date.text = creditCardModel.expiryDate;
    cardName.text = creditCardModel.cardHolderName;
    cvv.text = creditCardModel.cvvCode;
    isCvvFocused = creditCardModel.isCvvFocused;
    notifyListeners();
  }
  

  LatLng? locatizationBD;

  bool formValidationPD() {
    return (formKeyPD.currentState!.validate()) ? true : false;
  }

  bool formValidationCC() {
    return (formKeyCC.currentState!.validate()) ? true : false;
  }

  void activeNotifyListeners() {
    notifyListeners();
  }

  void changeValuesShippingDetails() {
    sameAsPD = !sameAsPD;
    if (sameAsPD) {
      parsedAddress1BD.text = parsedAddress1SD.text;
      parsedAddress2BD.text = parsedAddress2SD.text;
      parsedZipcodeBD.text = parsedZipcodeSD.text;
      parsedCityBD.text = parsedCitySD.text;
      parsedStateBD.text = parsedStateSD.text;

    } else {
      parsedAddress1BD.text = "";
      parsedAddress2BD.text = "";
      parsedZipcodeBD.text = "";
      parsedCityBD.text = "";
      parsedStateBD.text = "";
    }
    notifyListeners();
  }

  
}