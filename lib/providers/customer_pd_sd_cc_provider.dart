

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_maps/google_maps.dart';
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/models/state.dart';

class CustomerPDSDCCProvider with ChangeNotifier {

  List<States> states = [];
  Map<String, String> stateCodes = {};

  CustomerPDSDCCProvider({bool notify = true}) {
    getStates(notify: notify);
  }

  //Función para recuperar el código del catálogo de "state"
  Future<void> getStates({bool notify = true}) async {
    try {
      states.clear();

      final res = await supabase.from('state').select().order(
            'code',
            ascending: true,
          );

      states = (res as List<dynamic>).map((state) => States.fromJson(jsonEncode(state))).toList();

      for (var state in states) {
        final newState = <String, String>{state.code : state.name};
        stateCodes.addAll(newState);
      }

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getStates() -$e');
    }
  }


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
  final TextEditingController parsedStateCodeSD = TextEditingController(text: "");

  LatLng? locatizationPDSD;
  

  // Billing Details

  final TextEditingController parsedAddress1BD = TextEditingController(text: "");
  final TextEditingController parsedAddress2BD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeBD = TextEditingController(text: "");
  final TextEditingController parsedCityBD = TextEditingController(text: "");
  final TextEditingController parsedStateBD = TextEditingController(text: "");
  final TextEditingController parsedStateCodeBD = TextEditingController(text: "");

  //Card Variables
  TextEditingController number = TextEditingController(text:"");
  TextEditingController cvv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;


  void selectStateUpdateSD(String newState) {
    parsedStateSD.text = newState; 
    parsedStateCodeSD.text = stateCodes[newState] ?? "";
    notifyListeners();
  }

  void selectStateUpdateBD(String newState) {
    parsedStateBD.text = newState; 
    parsedStateCodeBD.text = stateCodes[newState] ?? "";
    notifyListeners();
  }

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
      parsedStateCodeBD.text = parsedStateCodeSD.text;

    } else {
      parsedAddress1BD.text = "";
      parsedAddress2BD.text = "";
      parsedZipcodeBD.text = "";
      parsedCityBD.text = "";
      parsedStateBD.text = "";
      parsedStateCodeBD.text = "";
    }
    notifyListeners();
  }

  
}