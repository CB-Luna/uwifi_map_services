// ignore_for_file: constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:http/http.dart' as http;
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/data/constants.dart';

enum Plan { residential, business, wholesale }

enum Location { cry, ode, smi, cry_sh, cry_hf, cry_bch }

enum Technology { fiber, fixedWireless }

enum Steps {
  firstStep,
  secondStep,
  thirdStep,
  firstExcepStep,
  firstExcepExtraStep,
  secondExcepStep,
  thirdExcepStep
}

Steps _step = Steps.firstStep;

class PopupController extends ChangeNotifier {
  //Constructor
  PopupController({required this.customerInfo}) {
    _step = customerInfo.customerRep != "" ? Steps.firstStep : Steps.secondStep;
  }

  CustomerInfo customerInfo;

  Location location = Location.cry;
  Technology technology = Technology.fiber;
  bool planSwitch = true;
  Plan plan = Plan.residential;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  get step => _step;

  //Text Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  //input fields
  late String firstName, lastName, phone, email;
  bool _emailCheckbox = true,
      _smsCheckbox = true,
      _internetCheckbox = true,
      _voiceCheckbox = true;

  bool get emailCheckbox => _emailCheckbox;
  bool get smsCheckbox => _smsCheckbox;
  bool get internetCheckbox => _internetCheckbox;
  bool get voiceCheckbox => _voiceCheckbox;

  void setEmailCheckbox(bool? value) {
    _emailCheckbox = value ?? true;
    notifyListeners();
  }

  void setSmsCheckbox(bool? value) {
    _smsCheckbox = value ?? true;
    notifyListeners();
  }

  void setInternetCheckbox(bool? value) {
    if (value == false && _voiceCheckbox == false) {
      null;
    } else {
      _internetCheckbox = value ?? true;
      notifyListeners();
    }
  }

  void setVoiceCheckbox(bool? value) {
    if (value == false && _internetCheckbox == false) {
      null;
    } else {
      _voiceCheckbox = value ?? true;
      notifyListeners();
    }
  }

  bool validateForm() {
    return formKey.currentState!.validate() ? true : false;
  }

  void setPlan() {
    if (planSwitch) {
      plan = Plan.residential;
    } else {
      plan = Plan.business;
    }
    notifyListeners();
  }

  void setLocation(location) {
    this.location = location;
    notifyListeners();
  }

  void setTechnology(technology) {
    this.technology = technology;
    notifyListeners();
  }

  Future<void> createLead() async {
    LatLng location = customerInfo.location;
    Map<String, dynamic> lead = {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': email,
      'phone': [
        {
          'Type': 'Mobile',
          'Number': phone,
        }
      ],
      'physicalStreet': customerInfo.street,
      'physicalCity': customerInfo.city,
      'physicalState': customerInfo.state,
      'physicalZip': customerInfo.zipcode,
      'physicalLatitude': location.lat.toString(),
      'physicalLongitude': location.lng.toString(),
    };

    Map<String, dynamic> body = {
      'apiKey': '3cBEFVR4qQleIRO2yWu0FcOCDdyZbuaU',
      'action': 'no_coverage_lead',
      'customer': lead,
      "contactPreference": {
        "promoInfobyEmail": _emailCheckbox,
        "promoInfobySMS": _smsCheckbox
      }
    };

    try {
      var url = Uri.parse('$env/planbuilder/api');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (e) {
      // ignore: avoid_print
      print('ERROR - function createLead(): $e');
    }
  }

  Future<void> createCoverageLead() async {
    final LatLng location = customerInfo.location;
    Map<String, dynamic> customer = {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': email,
      'phone': [
        {
          'Type': 'Mobile',
          'Number': phone,
        }
      ],
      'customerNotes': '',
      'physicalStreet': customerInfo.street,
      'physicalCity': customerInfo.city,
      'physicalState': customerInfo.state,
      'physicalZip': customerInfo.zipcode,
      'physicalLatitude': location.lat.toString(),
      'physicalLongitude': location.lng.toString(),
    };

    Map<String, bool> contactPreference = {
      'promoInfobyEmail': _emailCheckbox,
      'promoInfobySMS': _smsCheckbox,
    };

    final Map<String, bool> services = {
      'internet': _internetCheckbox,
      'voice': _voiceCheckbox,
    };

    final Map<String, dynamic> body = {
      'apiKey': '3cBEFVR4qQleIRO2yWu0FcOCDdyZbuaU',
      'action': 'createCoverageLead',
      'customerType': customerInfo.serviceType,
      'networkType': customerInfo.coverageType,
      'locationGroup': customerInfo.locationGroup,
      'customer': customer,
      'contactPreference': contactPreference,
      'servicesInterest': services,
    };
    try {
      var url = Uri.parse('$env/planbuilder/api');

      final response = await http.post(
        url,
        //headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (e) {
      // ignore: avoid_print
      print('ERROR - function createCoverageLead(): $e');
    }
  }

  void changeStep() {
    switch (_step) {
      case Steps.firstStep:
        _step = Steps.secondStep;
        break;
      case Steps.secondStep:
        _step = Steps.thirdStep;
        break;

      case Steps.firstExcepStep:
        customerInfo.locationGroup == Location.cry.name
            ? _step = Steps.firstExcepExtraStep
            : _step = Steps.secondExcepStep;
        break;

      case Steps.firstExcepExtraStep:
        _step = Steps.secondExcepStep;
        break;

      case Steps.secondExcepStep:
        _step = Steps.thirdExcepStep;
        break;

      default:
        break;
    }
    notifyListeners();
  }

  enterExceptionFlow() {
    _step = Steps.firstExcepStep;
    notifyListeners();
  }
}
