import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps/google_maps.dart' hide Place;

import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/models/coverage_validate.dart';
import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/models/domain/repositories/geocode_repository.dart';
import 'package:uwifi_map_services/models/domain/tileset.dart';
import 'package:uwifi_map_services/models/domain/repositories/suggestions_repository.dart';
import 'package:uwifi_map_services/models/geocode.dart';
import 'package:uwifi_map_services/models/reverse_geocode.dart';
import 'package:uwifi_map_services/providers/helpers/search_controller_helper.dart';
import 'package:uwifi_map_services/router/query_params.dart';

class SearchLocalController extends ChangeNotifier {
  final SuggestionsRepository _searchRepository;
  final GeocodeRepository _geocodeRepository;

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
      street = '',
      city = '',
      state = '',
      zipcode = '',
      _query = '',
      customerRep = '',
      origin = '',
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

  //Text Controllers Form View
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipcodeController = TextEditingController();

  //Text Controllers Form Portability View
  final streetPortController = TextEditingController();
  final cityPortController = TextEditingController();
  final statePortController = TextEditingController();
  final zipcodePortController = TextEditingController();

  String address = '';

  late LatLng currentLocation;

  SearchLocalController(
      this._searchRepository, this._geocodeRepository, this.key) {
    //initialize
    if (QueryParams.instance != null) {
      if (QueryParams.instance?.isAddress == true) {
        addressPrefilled = true;
        origin = "Website Form";
      } else {
        origin = QueryParams.instance?.origin ?? '';
      }
      customerRep = QueryParams.instance?.customerRep ?? '';
    }
    setSubscriptions();
  }

  Future<void> initForm() async {
    street = QueryParams.instance?.street ?? '';
    zipcode = QueryParams.instance?.zipcode ?? '';

    await getLocation();

    helper.initialLocation = currentLocation;

    changeValuesInputs();
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

    //Marker dragged subscription
    _markerDraggedSubscription = helper.marker.onDragend.listen((_) {
      getAddress(helper.marker.position!, helper.infoWindow);
      locationConfirmed = true;
      currentLocation = helper.marker.position!;
      notifyListeners();
    });

    //Marker clicked subscription
    _markerClickedSubscription = helper.marker.onClick.listen((_) {
      if (helper.infoWindow.content != '') {
        helper.infoWindow.open(helper.map, helper.marker);
      }
      notifyListeners();
    });
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
      if (streetNumber != '') {
        streetController.text = '$streetNumber ${temp[0]}';
        street = '$streetNumber ${temp[0]}';
      } else {
        streetController.text = temp[0];
        street = temp[0];
      }
      cityController.text = temp[1];
      city = temp[1];
      temp = temp[2].split(' ');
      stateController.text = temp[0];
      state = temp[0];
      zipcodeController.text = temp[1];
      zipcode = temp[1];
    }
    notifyListeners();
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

  void changeValuesInputs() {
    streetController.text = street;
    cityController.text = city;
    stateController.text = state;
    zipcodeController.text = zipcode;
  }

  void fillAddressFields() {
    street = streetController.text;
    city = cityController.text;
    state = stateController.text;
    zipcode = zipcodeController.text;
  }

  Future<void> getLocation() async {
    final Geocode? geocode = await _geocodeRepository.geocode(
      street: street,
      zipcode: zipcode,
    );
    if (geocode != null) {
      if (geocode.items.isEmpty) {
        //Address not found
        isVisibleWarning = true;
      } else {
        city = geocode.items[0].address.city.toString();
        state = geocode.items[0].address.stateCode.toString();
        changeLocation(
          LatLng(
            geocode.items[0].position.lat,
            geocode.items[0].position.lng,
          ),
        );
      }
    } else {
      //Request failed
      isVisibleWarning = true;
    }
    changeValuesInputs();
    notifyListeners();
  }

  void getAddress(LatLng position, InfoWindow infoWindow) async {
    try {
      final lat = position.lat;
      final lng = position.lng;
      var url = Uri.parse(
          'https://revgeocode.search.hereapi.com/v1/revgeocode?apiKey=-plDP_dR7XAGxBSiHgTFyxkxNdjFFHqjQK9ge8b92CE&at=$lat,$lng&lang=en-US');

      var response = await http.get(url);
      final reverseGeocode = ReverseGeocode.fromJson(response.body);

      if (reverseGeocode.items.isEmpty) {
        // ignore: avoid_print
        print('Location not found');
      } else {
        final addressResult = reverseGeocode.items[0].address;
        street = '${addressResult.houseNumber} ${addressResult.street}';
        city = addressResult.city;
        state = addressResult.state;
        zipcode = addressResult.postalCode;

        address = '$street, $city, $state, $zipcode';
        infoWindow.content = address;
        changeValuesInputs();
      }
    } catch (e) {
      // ignore: avoid_print
      print('ERROR - function getAddress(): $e');
    }
  }

  void clearPlaces() {
    _places = [];
    notifyListeners();
  }

  void changeLocation(LatLng coordinates) {
    _mapLocationController.sink.add(coordinates);
    currentLocation = coordinates;
    _location = null;
    notifyListeners();
  }

  Future<String> getTilesets(double lat, double long) async {
    if (lat == 0 && long == 0) {
      return 'Please drag the marker\nor enter an address.';
    } else {
      try {
        var url = Uri.parse(
            'https://api.mapbox.com/v4/uzzielpalma99.ckxqm75om68v520tg5ahci92h-6ebbj/tilequery/$long,$lat.json?radius=500&limit=5&geometry=linestring&access_token=pk.eyJ1IjoidXp6aWVscGFsbWE5OSIsImEiOiJja3hoeWxxaHUwYjVhMndvYzdkMW4wbTAzIn0.JGPo9_pMeml93PD7bELQRg');

        var response = await http.get(url);

        final tileset = Tileset.fromJson(response.body);

        return validateFiber(tileset.features);
      } catch (e) {
        // ignore: avoid_print
        print('Exception on get Tilesets: $e');
        return 'None';
      }
    }
  }

  Future<String> getCoverageValidation() async {
    try {
      final lat = currentLocation.lat;
      final long = currentLocation.lng;
      var url = Uri.parse(
          '$env/planbuilder/validate/coverage?lat=$lat&long=$long&zipcode=$zipcode');
      var response = await http.get(url);
      final coveragevalidate = CoverageValidate.fromJson(response.body);
      // ignore: avoid_print
      print('flow');
      // ignore: avoid_print
      print(coveragevalidate.result.flow);
      getflow(coveragevalidate.result);
      getLocationGroup(coveragevalidate.result);

      return validateRTACoverage(coveragevalidate.result);
    } catch (e) {
      // ignore: avoid_print
      print('Exception on Coverage Validation: $e');
      return 'None';
    }
  }

  void getLocationGroup(result) {
    if (result.locationgroup == null) {
      locationgroup = "";
    } else {
      locationgroup = result.locationgroup!;
    }
    notifyListeners();
  }

  void getflow(Result result) {
    if (result.flow == null) {
      flow = "";
    } else {
      flow = result.flow!;
    }
    notifyListeners();
  }

  String validateFiber(List<Feature> features) {
    if (features.isEmpty) {
      return 'None';
    }
    final distance = features[0].properties.tilequery.distance * 3.28;
    if (distance > 500) {
      return 'None';
    }
    return 'Fiber';
  }

  String validateRTACoverage(Result results) {
    if (results.coverage == false) {
      return 'None';
    } else {
      return results.type!;
    }
  }

  Future<bool> confirm() async {
    isLoading = true;
    notifyListeners();
    coverageType = await getCoverageValidation();
    isLoading = false;
    notifyListeners();
    return coverageType == 'None' ? false : true;
  }

  CustomerInfo fillCustomerInfo() {
    CustomerInfo customerInfo = CustomerInfo(
        street: street,
        city: city,
        state: state,
        zipcode: zipcode,
        coverageType: coverageType,
        locationGroup: locationgroup,
        location: currentLocation,
        customerRep: customerRep,
        origin: origin);
    return customerInfo;
  }

  void emptyCoverage() {
    coverageType = '';
  }

  void clickOKWarning() {
    isVisibleWarning = false;
    notifyListeners();
  }

  void confirmLocation() {
    locationConfirmed = true;
    notifyListeners();
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('Entered SearchController dispose()');
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipcodeController.dispose();
    _debouncer?.cancel();
    _suggestionsSubscription.cancel();
    _locationSubscription.cancel();
    _markerDraggedSubscription.cancel();
    _markerClickedSubscription.cancel();
    _searchRepository.dispose();
    _geocodeRepository.dispose();
    _mapLocationController.close();
    super.dispose();
  }
}
