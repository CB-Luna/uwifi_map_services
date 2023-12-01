

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CustomerShippingInfo with ChangeNotifier {
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

  //controllers for the Card Info
  final TextEditingController parsedName = TextEditingController(text: "");

  //Card Variables
  String number = '';
  String ccv = '';
  String date = '';
  String cardName = '';
  bool isCvvFocused = false;

  //Variables de Envio
  String address1SD = '';
  String address2SD = '';
  String nameSD ='';
  String lastNameSD ='';
  String phoneSD ='';
  String zipcodeSD = '';
  String stateSD = '';
  String citySD = '';

  //Variables de Cliente
  String lastNamePD = '';
  String firstNamePD = '';
  String phonePD = '';
  String address1PD = '';
  String address2PD = '';
  String custEmailPD = '';

  // Funciones Personal Details
  void setlName(String value) {
    lastNamePD = value;
    notifyListeners();
  }

  void setfName(String value) {
    firstNamePD = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phonePD = value;
    // notifyListeners();
  }
  void setAddress1(String value){
    address1PD = value;
    notifyListeners();
  }

  void setAddress2(String value){
    address2PD = value;
    notifyListeners();
  }

  void setEmail(String value) {
    custEmailPD = value;
    notifyListeners();
  }

  //Functions for the card
  void setCard(String value){
    number = value;
    notifyListeners();
  }
  void setCcv(String value){
    ccv=value;
    notifyListeners();
  }
  void setDate(String value){
    date = value;
    notifyListeners();
  }
  void setCardName(String value){
    cardName = value;
    notifyListeners();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      number = creditCardModel.cardNumber;
      date = creditCardModel.expiryDate;
      cardName = creditCardModel.cardHolderName;
      ccv = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    } as String);
  }

  // Funciones Shipping Details
  void setAddress1Shipping(String value){
    address1SD = value;
    notifyListeners();
  }

  void setAddress2Shipping(String value){
    address2SD = value;
    notifyListeners();
  }

  void setNameShipping(String value){
    nameSD = value;
    notifyListeners();
  }
  
  void setLastNameShipping(String value){
    lastNameSD = value;
    notifyListeners();
  }

  void setphoneShipping(String value){
    phoneSD = value;
    notifyListeners(); 
  }

  void setZipcode(String value){
    zipcodeSD = value;
    notifyListeners();
  }

  void setCity(String value){
    citySD = value;
    notifyListeners();
  }

  void setState(String value){
    stateSD = value;
    notifyListeners();
  }


  
}