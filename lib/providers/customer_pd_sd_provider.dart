

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

class CustomerPDSDProvider with ChangeNotifier {
  final SuggestionsRepository _searchRepository;

  Key key;

  bool isVisibleWarning = false,
      isLoading = false,
      addressPrefilled = false,
      hasSuggestions = false,
      locationConfirmed = false;
  //Strings Form View
  String coverageType = '',
      locationgroup = '',
      _query = '',
      customerRep = '',
      flow = '';
  //Strings Form Portability View
  String street= '', city= '', state= '', zipcode= '';

  String get query => _query;

  Timer? _debouncer;

  List<Place>? _places = [];
  List<Place>? get places => _places;
  Place? _location;
  Place? get location => _location;

  //Stream controller for position changes
  final StreamController<LatLng?> _mapLocationController =
      StreamController.broadcast();
  //Stream that corresponds to controller
  Stream<LatLng?> get onResults => _mapLocationController.stream;

  //Subscriptions
  late StreamSubscription _suggestionsSubscription;
  
  // Personal Details
  final TextEditingController parsedFNamePD = TextEditingController(text: "");
  final TextEditingController parsedLNamePD = TextEditingController(text: "");
  final TextEditingController parsedPhonePD = TextEditingController(text: "");
  final TextEditingController parsedEmailPD = TextEditingController(text: "");

  // Shipping Details
  final TextEditingController parsedAddress1SD = TextEditingController(text: "");
  final TextEditingController parsedAddress2SD = TextEditingController(text: "");
  final TextEditingController parsedZipcodeSD = TextEditingController(text: "");
  final TextEditingController parsedCitySD = TextEditingController(text: "");
  final TextEditingController parsedStateSD = TextEditingController(text: "");
  final TextEditingController parsedStateCodeSD = TextEditingController(text: "");

  LatLng? positionSD;

  CustomerPDSDProvider(this._searchRepository, this.key, {bool notify = true}) {
    //initialize
    getStates(notify: notify);
    setSubscriptions();
  }

  void setSubscriptions() {
    //Suggestions subscription
    _suggestionsSubscription = _searchRepository.onResults.listen(
      (results) {
        _places = results;
        notifyListeners();
      },
    );
  }

  void onAddressChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(
      const Duration(milliseconds: 400),
      () {
        if (_query.length >= 3) {
          debugPrint("Call to API");
          _searchRepository.cancel();
          _searchRepository.search(
            _query,
            LatLng(29.62540053919014, -95.39478748016545),
          );
        } else {
          debugPrint("cancel API call");
          _searchRepository.cancel();
          clearPlaces();
        }
      },
    );
  }

  void pickPlace(Place place, String streetNumber) {
    _location = place;
    if (place.type == 'street') {
      List<String> temp =
          place.address.split(',').map((e) => e.trim()).toList();
      if (streetNumber!= '') {
        parsedAddress1SD.text = '$streetNumber${temp[0]}';
        street= '$streetNumber${temp[0]}';
      } else {
        parsedAddress1SD.text = temp[0];
        street= temp[0];
      }
      parsedCitySD.text = temp[1];
      city= temp[1];
      temp = temp[2].split(' ');
      parsedStateCodeSD.text = temp[0];
      state= temp[0];
      if (state != "") {
        parsedStateSD.text = stateCodes[state]!;
      }  
      parsedZipcodeSD.text = temp[1];
      zipcode= temp[1];
      positionSD = place.position;
    }
    notifyListeners();
  }

  void clearPlaces() {
    _places = [];
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
    _debouncer?.cancel();
    _suggestionsSubscription.cancel();
    _searchRepository.dispose();
    _mapLocationController.close();
    super.dispose();
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
  
  //Bandera Checkbox SD same as PD
  bool sameAsPD = true;

  // Personal Details
  GlobalKey<FormState> formKeyPD = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyCC = GlobalKey<FormState>();
  

  

  LatLng? locatizationSD;

  bool formValidationPD() {
    return (formKeyPD.currentState!.validate()) ? true : false;
  }

  void activeNotifyListeners() {
    notifyListeners();
  }


  void selectStateUpdateSD(String newState) {
    parsedStateSD.text = newState; 
    parsedStateCodeSD.text = stateCodes[newState] ?? "";
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