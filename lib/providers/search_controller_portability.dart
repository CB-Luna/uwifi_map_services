import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart' hide Place;

import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/models/domain/repositories/suggestions_repository.dart';

class SearchControllerPortability extends ChangeNotifier {
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
  String streetPort = '', cityPort = '', statePort = '', zipcodePort = '';

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
  late StreamSubscription _locationSubscription;
  late StreamSubscription _markerDraggedSubscription;
  late StreamSubscription _markerClickedSubscription;

  //Text Controllers Form Portability View
  final streetPortController = TextEditingController();
  final cityPortController = TextEditingController();
  final statePortController = TextEditingController();
  final zipcodePortController = TextEditingController();

  String address = '';

  late LatLng currentLocation;

  SearchControllerPortability(this._searchRepository, this.key) {
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
    // ignore: avoid_print
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
