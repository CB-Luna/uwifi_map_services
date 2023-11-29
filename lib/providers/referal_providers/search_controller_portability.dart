// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Place;

import '../../models/domain/place.dart';
import '../../models/domain/repositories/suggestions_repository.dart';
import '../helpers/search_controller_helper.dart';

class SearchControllerPortability extends ChangeNotifier {
  final SuggestionsRepository _searchRepository;

  final SearchControllerHelper helper = SearchControllerHelper();

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
      _queryF = '',
      customerRep = '',
      flow = '';
  //Strings Form Portability View
  String streetPort = '', cityPort = '', statePort = '', zipcodePort = '';
  String street = '', city = '', state = '', zipcode = '';

  String get query => _query;

  Timer? _debouncer;
  Timer? _debouncerF;

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
  late StreamSubscription _locationSubscription;
  late StreamSubscription _markerDraggedSubscription;
  late StreamSubscription _markerClickedSubscription;

  //Text Controllers Form Portability View
  final streetPortController = TextEditingController();
  final cityPortController = TextEditingController();
  final statePortController = TextEditingController();
  final zipcodePortController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  String address = '';

  late LatLng currentLocation;

  SearchControllerPortability(this._searchRepository, this.key) {
    print('controller created');
    //initialize
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

    //Location changed subscription (apply button clicked)
    _locationSubscription = onResults.listen((newLocation) {
      helper.marker.position = newLocation;
      helper.map.center = newLocation;
      notifyListeners();
    });
  }

  void onAddressChangedFormView(String text) {
    _queryF = text;
    _debouncerF?.cancel();
    _debouncerF = Timer(
      const Duration(milliseconds: 400),
      () {
        if (_queryF.length >= 3) {
          debugPrint("Call to API");
          _searchRepository.cancel();
          _searchRepository.search(
            _queryF,
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

  void pickPlacePortabilityF(Place place, String streetNumberPort) {
    _location = place;
    if (place.type == 'street') {
      List<String> temp =
          place.address.split(',').map((e) => e.trim()).toList();
      if (streetNumberPort != '') {
        addressController.text = '$streetNumberPort ${temp[0]}';
        street = '$streetNumberPort ${temp[0]}';
      } else {
        addressController.text = temp[0];
        street = temp[0];
      }
      cityController.text = temp[1];
      city = temp[1];
      temp = temp[2].split(' ');
      stateController.text = temp[0];
      state = temp[0];
      zipController.text = temp[1];
      zipcode = temp[1];
    }
    notifyListeners();
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

  void pickPlacePortability(Place place, String streetNumberPort) {
    _location = place;
    if (place.type == 'street') {
      List<String> temp =
          place.address.split(',').map((e) => e.trim()).toList();
      if (streetNumberPort != '') {
        streetPortController.text = '$streetNumberPort ${temp[0]}';
        streetPort = '$streetNumberPort ${temp[0]}';
      } else {
        streetPortController.text = temp[0];
        streetPort = temp[0];
      }
      cityPortController.text = temp[1];
      cityPort = temp[1];
      temp = temp[2].split(' ');
      statePortController.text = temp[0];
      statePort = temp[0];
      zipcodePortController.text = temp[1];
      zipcodePort = temp[1];
    }
    notifyListeners();
  }

  void clearPlaces() {
    _places = [];
    notifyListeners();
  }

  @override
  void dispose() {
    print('Entered SearchController dispose()');
    streetPortController.dispose();
    cityPortController.dispose();
    statePortController.dispose();
    zipcodePortController.dispose();
    _debouncer?.cancel();
    _suggestionsSubscription.cancel();
    _locationSubscription.cancel();
    _markerDraggedSubscription.cancel();
    _markerClickedSubscription.cancel();
    _searchRepository.dispose();
    _mapLocationController.close();
    super.dispose();
  }
}
