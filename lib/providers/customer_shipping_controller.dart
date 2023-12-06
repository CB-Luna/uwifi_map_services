

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:google_maps/google_maps.dart';

class CustomerShippingInfo with ChangeNotifier {
  //Bandera Checkbox SD same as PD
  bool sameAsPD = true;

  // Personal Details
  GlobalKey<FormState> formKeyPD = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyCC = GlobalKey<FormState>();
  final TextEditingController parsedFNamePD = TextEditingController(text: "");
  final TextEditingController parsedLNamePD = TextEditingController(text: "");
  final TextEditingController parsedPhonePD = TextEditingController(text: "");
  final TextEditingController parsedEmailPD = TextEditingController(text: "");
  final TextEditingController parsedAddress1PD = TextEditingController(text: "");
  final TextEditingController parsedAddress2PD = TextEditingController(text: "");
  final TextEditingController parsedZipcodePD = TextEditingController(text: "");
  final TextEditingController parsedCityPD = TextEditingController(text: "");
  final TextEditingController parsedStatePD = TextEditingController(text: "");

  LatLng? locatizationPD;
  

  // Shipping Details
  final TextEditingController parsedFNameSD = TextEditingController(text: "");
  final TextEditingController parsedLNameSD = TextEditingController(text: "");
  final TextEditingController parsedPhoneSD = TextEditingController(text: "");
  final TextEditingController parsedAddress1SD = TextEditingController(text: "");
  final TextEditingController parsedAddress2SD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeSD = TextEditingController(text: "");
  final TextEditingController parsedCitySD = TextEditingController(text: "");
  final TextEditingController parsedStateSD = TextEditingController(text: "");

  LatLng? locatizationSD;

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
  

  
}