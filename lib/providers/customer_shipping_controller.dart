

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomerShippingInfo with ChangeNotifier {
  //Bandera Checkbox SD same as PD
  bool sameAsPD = false;

  // Personal Details
  GlobalKey<FormState> formKeyPD = GlobalKey<FormState>();
  final TextEditingController parsedFNamePD = TextEditingController(text: "");
  final TextEditingController parsedLNamePD = TextEditingController(text: "");
  final TextEditingController parsedPhonePD = TextEditingController(text: "");
  final TextEditingController parsedEmailPD = TextEditingController(text: "");
  final TextEditingController parsedAddress1PD = TextEditingController(text: "");
  final TextEditingController parsedAddress2PD = TextEditingController(text: "");
  final TextEditingController parsedZipcodePD = TextEditingController(text: "");
  final TextEditingController parsedCityPD = TextEditingController(text: "");
  final TextEditingController parsedStatePD = TextEditingController(text: "");

  // Shipping Details
  final TextEditingController parsedFNameSD = TextEditingController(text: "");
  final TextEditingController parsedLNameSD = TextEditingController(text: "");
  final TextEditingController parsedPhoneSD = TextEditingController(text: "");
  final TextEditingController parsedAddress1SD = TextEditingController(text: "");
  final TextEditingController parsedAddress2SD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeSD = TextEditingController(text: "");
  final TextEditingController parsedCitySD = TextEditingController(text: "");
  final TextEditingController parsedStateSD = TextEditingController(text: "");

  bool formValidation() {
    return (formKeyPD.currentState!.validate()) ? true : false;
  }
  void activeNotifyListeners() {
    notifyListeners();
  }
  
  void changeValuesShoppingDetails() {
    sameAsPD = !sameAsPD;
    if (sameAsPD) {
      parsedFNameSD.text = parsedFNamePD.text;
      parsedLNameSD.text = parsedLNamePD.text;
      parsedPhoneSD.text = parsedPhonePD.text;
      parsedAddress1SD.text = parsedAddress1PD.text;
      parsedAddress2SD.text = parsedAddress2PD.text;
      parsedZipcodeSD.text = parsedZipcodePD.text;
      parsedCitySD.text = parsedCityPD.text;
      parsedStateSD.text = parsedStatePD.text;

    } else {
      parsedFNameSD.text = "";
      parsedLNameSD.text = "";
      parsedPhoneSD.text = "";
      parsedAddress1SD.text = "";
      parsedAddress2SD.text = "";
      parsedZipcodeSD.text = "";
      parsedCitySD.text = "";
      parsedStateSD.text = "";
    }
    notifyListeners();
  }

  //controllers for the Card Info
  final TextEditingController parsedName = TextEditingController(text: "");

  //Card Variables
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  void onCreditCardModelChange() {
    notifyListeners();
  }

  

  
}