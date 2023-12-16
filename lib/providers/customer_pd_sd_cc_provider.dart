

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_maps/google_maps.dart' hide Place;
import 'package:uwifi_map_services/helpers/globals.dart';
import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/models/domain/repositories/suggestions_repository.dart';
import 'package:uwifi_map_services/models/state.dart';

class CustomerPDSDCCProvider with ChangeNotifier {

  final SuggestionsRepository _searchRepositorySD;
  final SuggestionsRepository _searchRepositoryBD;

  Key key;

  CustomerPDSDCCProvider(this._searchRepositorySD, this._searchRepositoryBD, this.key, {bool notify = true}) {
    //initialize
    getStates(notify: notify);
    setSubscriptionsSD();
    setSubscriptionsBD();
  }

  List<States> states = [];
  Map<String, String> stateCodes = {};


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


  // Personal Details
  GlobalKey<FormState> formKeyPD = GlobalKey<FormState>();
  final TextEditingController parsedFNamePD = TextEditingController(text: "");
  final TextEditingController parsedLNamePD = TextEditingController(text: "");
  final TextEditingController parsedPhonePD = TextEditingController(text: "");
  final TextEditingController parsedEmailPD = TextEditingController(text: "");

  bool formValidationPD() {
    return (formKeyPD.currentState!.validate()) ? true : false;
  }

  // Shipping Details
  //<<Form>>
  final TextEditingController parsedAddress1SD = TextEditingController(text: "");
  final TextEditingController parsedAddress2SD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeSD = TextEditingController(text: "");
  final TextEditingController parsedCitySD = TextEditingController(text: "");
  final TextEditingController parsedStateSD = TextEditingController(text: "");
  final TextEditingController parsedStateCodeSD = TextEditingController(text: "");
  //<<AutoFill Address>>
  LatLng? positionSD;
  bool isVisibleWarningSD = false,
      isLoadingSD = false,
      addressPrefilledSD = false,
      hasSuggestionsSD = false,
      locationConfirmedSD = false;
  //Strings Form View
  String coverageTypeSD = '',
      locationgroupSD = '',
      _querySD = '',
      customerRepSD = '',
      flowSD = '';
  //Strings Form Portability View
  String streetSD = '', citySD = '', stateSD = '', zipcodeSD = '';

  String get querySD => _querySD;

  Timer? _debouncerSD;

  List<Place>? _placesSD = [];
  List<Place>? get placesSD => _placesSD;
  Place? _locationSD;
  Place? get locationSD => _locationSD;

  //Stream controller for position changes
  final StreamController<LatLng?> _mapLocationControllerSD =
      StreamController.broadcast();
  //Stream that corresponds to controller
  Stream<LatLng?> get onResultsSD => _mapLocationControllerSD.stream;

  //Subscriptions
  late StreamSubscription _suggestionsSubscriptionSD;

  void setSubscriptionsSD() {
    //Suggestions subscription
    _suggestionsSubscriptionSD = _searchRepositorySD.onResults.listen(
      (results) {
        _placesSD = results;
        notifyListeners();
      },
    );
  }

  void onAddressChangedSD(String text) {
    _querySD = text;
    _debouncerSD?.cancel();
    _debouncerSD = Timer(
      const Duration(milliseconds: 400),
      () {
        if (_querySD.length >= 3) {
          debugPrint("Call to API");
          _searchRepositorySD.cancel();
          _searchRepositorySD.search(
            _querySD,
            LatLng(29.62540053919014, -95.39478748016545),
          );
        } else {
          debugPrint("cancel API call");
          _searchRepositorySD.cancel();
          clearPlacesSD();
        }
      },
    );
  }

  void pickPlaceSD(Place place, String streetNumber) {
    _locationSD = place;
    if (place.type == 'street') {
      List<String> temp =
          place.address.split(',').map((e) => e.trim()).toList();
      if (streetNumber!= '') {
        parsedAddress1SD.text = '$streetNumber${temp[0]}';
        streetSD = '$streetNumber${temp[0]}';
      } else {
        parsedAddress1SD.text = temp[0];
        streetSD = temp[0];
      }
      parsedCitySD.text = temp[1];
      citySD = temp[1];
      temp = temp[2].split(' ');
      parsedStateCodeSD.text = temp[0];
      stateSD = temp[0];
      if (stateSD != "") {
        parsedStateSD.text = stateCodes[stateSD]!;
      }  
      parsedZipcodeSD.text = temp[1];
      zipcodeSD = temp[1];
      positionSD = place.position;
    }
    notifyListeners();
  }

  void clearPlacesSD() {
    _placesSD = [];
    notifyListeners();
  }

  void selectStateUpdateSD(String newState) {
    parsedStateSD.text = newState; 
    parsedStateCodeSD.text = stateCodes[newState] ?? "";
    notifyListeners();
  }

  //Billing Details
  //<<Form>>
  //Bandera Checkbox BD same as SD
  bool sameAsSD = false;
  // Billing Details
  GlobalKey<FormState> formKeyCC = GlobalKey<FormState>();
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

  bool formValidationCC() {
    return (formKeyCC.currentState!.validate()) ? true : false;
  }

  void changeValuesBillingDetails() {
    sameAsSD = !sameAsSD;
    if (sameAsSD) {
      parsedAddress1BD.text = parsedAddress1SD.text;
      parsedAddress2BD.text = parsedAddress2SD.text;
      parsedZipcodeBD.text = parsedZipcodeSD.text;
      parsedCityBD.text = parsedCitySD.text;
      parsedStateBD.text = parsedStateSD.text;
      parsedStateCodeBD.text = parsedStateCodeSD.text;
      positionBD = positionSD;
    } else {
      parsedAddress1BD.text = "";
      parsedAddress2BD.text = "";
      parsedZipcodeBD.text = "";
      parsedCityBD.text = "";
      parsedStateBD.text = "";
      parsedStateCodeBD.text = "";
      positionBD = null;
    }
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

  //<<AutoFill Address>>
  LatLng? positionBD;
  bool isVisibleWarningBD = false,
      isLoadingBD = false,
      addressPrefilledBD = false,
      hasSuggestionsBD = false,
      locationConfirmedBD = false;
  //Strings Form View
  String coverageTypeBD = '',
      locationgroupBD = '',
      _queryBD = '',
      customerRepBD = '',
      flowBD = '';
  //Strings Form Portability View
  String streetBD = '', cityBD = '', stateBD = '', zipcodeBD = '';

  String get queryBD => _queryBD;

  Timer? _debouncerBD;

  List<Place>? _placesBD = [];
  List<Place>? get placesBD => _placesBD;
  Place? _locationBD;
  Place? get locationBD => _locationBD;

  //Stream controller for position changes
  final StreamController<LatLng?> _mapLocationControllerBD =
      StreamController.broadcast();
  //Stream that corresponds to controller
  Stream<LatLng?> get onResultsBD => _mapLocationControllerBD.stream;

  //Subscriptions
  late StreamSubscription _suggestionsSubscriptionBD;
  

  void setSubscriptionsBD() {
    //Suggestions subscription
    _suggestionsSubscriptionBD = _searchRepositoryBD.onResults.listen(
      (results) {
        _placesBD = results;
        notifyListeners();
      },
    );
  }

  void onAddressChangedBD(String text) {
    _queryBD = text;
    _debouncerBD?.cancel();
    _debouncerBD = Timer(
      const Duration(milliseconds: 400),
      () {
        if (_queryBD.length >= 3) {
          debugPrint("Call to API");
          _searchRepositoryBD.cancel();
          _searchRepositoryBD.search(
            _queryBD,
            LatLng(29.62540053919014, -95.39478748016545),
          );
        } else {
          debugPrint("cancel API call");
          _searchRepositoryBD.cancel();
          clearPlacesBD();
        }
      },
    );
  }

  void pickPlaceBD(Place place, String streetNumber) {
    _locationBD = place;
    if (place.type == 'street') {
      List<String> temp =
          place.address.split(',').map((e) => e.trim()).toList();
      if (streetNumber!= '') {
        parsedAddress1BD.text = '$streetNumber${temp[0]}';
        streetBD = '$streetNumber${temp[0]}';
      } else {
        parsedAddress1BD.text = temp[0];
        streetBD = temp[0];
      }
      parsedCityBD.text = temp[1];
      cityBD = temp[1];
      temp = temp[2].split(' ');
      parsedStateCodeBD.text = temp[0];
      stateBD = temp[0];
      if (stateBD != "") {
        parsedStateBD.text = stateCodes[stateBD]!;
      }  
      parsedZipcodeBD.text = temp[1];
      zipcodeBD = temp[1];
      positionBD = place.position;
    }
    notifyListeners();
  }


  void clearPlacesBD() {
    _placesBD = [];
    notifyListeners();
  }


  @override
  void dispose() {
    // ignore: avoid_print
    print('Entered SearchController dispose()');
    parsedAddress1SD.dispose();
    parsedCitySD.dispose();
    parsedStateCodeSD.dispose();
    parsedZipcodeSD.dispose();
    parsedAddress1BD.dispose();
    parsedCityBD.dispose();
    parsedStateCodeBD.dispose();
    parsedZipcodeBD.dispose();
    _debouncerSD?.cancel();
    _suggestionsSubscriptionSD.cancel();
    _searchRepositorySD.dispose();
    _searchRepositoryBD.dispose();
    _mapLocationControllerSD.close();
    _debouncerBD?.cancel();
    _suggestionsSubscriptionBD.cancel();
    _mapLocationControllerBD.close();
    super.dispose();
  }

  void activeNotifyListeners() {
    notifyListeners();
  }
  
}