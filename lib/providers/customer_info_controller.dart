// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:google_maps/google_maps.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/router/promo_params.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class CustomerInfoProvider with ChangeNotifier {
  final TextEditingController parsedFName = TextEditingController();
  final TextEditingController parsedLName = TextEditingController();
  final TextEditingController parsedPhone = TextEditingController();
  final TextEditingController parsedEmail = TextEditingController();
  final TextEditingController parsedAddress = TextEditingController();
  //controllers for the Card Info
  final TextEditingController parsedName = TextEditingController();

  //Card Variables
  String number = '';
  String ccv = '';
  String date = '';
  String cardName = '';

  //Variables de Envio
  String addressShip = '';
  String nameShip ='';
  String lastNameShip ='';
  String phoneShip='';
  String zipcode = '';
  String state = '';
  String city = '';

  String origin;
  String lastName = '';
  String firstName = '';
  String phone = '';
  String address = '';
  String address2 = '';
  String custEmail = '';
  String contactRange = 'Any time';
  bool contactByEmail = true;
  bool contactByPhone = true;
  String custNote = '';
  bool promoInfobyEmail = true;
  bool promoInfoibySMS = true;

  List<String> promos = [""];
  String kindOfPromo = "";
  bool isAList = false;

  bool ticketTV = false;
  bool ticketVoice = false;
  bool ticketServiceRequest = false;

  bool orderSent = false;

  bool portabilityCheck = false;

  Color panelcolor = const Color(0xFF2E5899);
  String? engageoption;

  //Portability
  Map<String, dynamic> portabilityInfo = {};
  String referralId = '';

  final TextEditingController engageSelect = TextEditingController();
  CustomerInfo customerInfo;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool formValidation() {
    return (formKey.currentState!.validate()) ? true : false;
  }

  CustomerInfoProvider(this.origin, {required this.customerInfo}) {
    // print('controller Customer created');
    //initialize
    if (PromoParams.instance != null) {
      // print('Promo almacenada');
      if (PromoParams.instance!.promo!.contains('-')) {
        // print('Promo almacenada 1');
        promos = (PromoParams.instance!.promo)!.split('-');
      } else {
        // print('Promo almacenada 2');
        promos.add(PromoParams.instance!.promo!);
      }

      // print("Promos: $promos");
      notifyListeners();
    }
  }

  void setlName(String lName) {
    lastName = lName;
    notifyListeners();
  }

  void setfName(String fname) {
    firstName = fname;
    notifyListeners();
  }

  void setPhone(String phone) {
    this.phone = phone;
    //notifyListeners();
  }
  void setAddress1(String address){
    this.address = address;
    notifyListeners();
  }

  void setAddress2(String value){
    this.address2 = value;
    notifyListeners();
  }

  void setEmail(String email) {
    custEmail = email;
    notifyListeners();
  }

  //Functions for the card
  void setCard(String card){
    number = card;
    notifyListeners();
  }
  void setCcv(String value){
    ccv=value;
    notifyListeners();
  }
  void setDate(String date){
    this.date=date;
    notifyListeners();
  }
  void setCardName(String name){
    cardName = name;
    notifyListeners();
  }
  //funciones para envio
  void setAddressShipping(String value){
    addressShip = value;
    notifyListeners();
  }

  void setNameShipping(String name){
    nameShip =name;
    notifyListeners();
  }
  
  void setLastNameShipping(String lastName){
    lastNameShip = lastName;
    notifyListeners();
  }

  void setphoneShipping(String phone){
    phoneShip = phone;
    notifyListeners();
  }

  void setZipcode(String value){
    zipcode = value;
    notifyListeners();
  }

  void setCity(String cit){
    city = cit;
    notifyListeners();
  }

  void setState(String stat){
    state = stat;
    notifyListeners();
  }

  //fin Funciones envio

  void setEngage(String engopt) {
    engageoption = engopt;
    notifyListeners();
  }

  
  void setColor(Color pancolor) {
    panelcolor = pancolor;
    notifyListeners();
  }

  void lockButton(bool value) {
    orderSent = value;
    notifyListeners();
  }

  void selectToogleButton(bool index1, bool index2) {
    // print(index1);
    // print(index2);
  }

  void addPortabilityInfo(
      String firstName,
      String lastName,
      String numberStreet,
      String city,
      String state,
      String zipcode,
      String requestedPortDate,
      String currentServiceProvider,
      List<String> telephoneNumber,
      List<String> billingTelephone) {
    //Cleaning lists
    telephoneNumber.removeWhere((element) => element == "");
    billingTelephone.removeWhere((element) => element == "");

    portabilityInfo['firstName'] = firstName;
    portabilityInfo['lastName'] = lastName;
    portabilityInfo['numberStreet'] = numberStreet;
    portabilityInfo['city'] = city;
    portabilityInfo['state'] = state;
    portabilityInfo['zipcode'] = zipcode;
    portabilityInfo['portDate'] = requestedPortDate;
    portabilityInfo['serviceProvider'] = currentServiceProvider;
    portabilityInfo['listTelephoneNumber'] = telephoneNumber;
    portabilityInfo['listbillingTelephone'] = billingTelephone;

    portabilityCheck = true;
  }

  Future<String> createOrder({
    required List<Product> services,
    required List<Product> devices,
    required List<Product> fees,
    required List<Product> additionals,
    required List<Product> discounts,
    String? referral,
  }) async {
    // print("discounts to send: ${discounts.map((e) => e.pwName)}");
    final LatLng location = customerInfo.location;
    Map<String, dynamic> customer = {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': custEmail,
      'phone': [
        {
          'Type': 'Mobile',
          'Number': phone,
        }
      ],
      'customerNotes': custNote,
      'physicalStreet': customerInfo.street,
      'physicalCity': customerInfo.city,
      'physicalState': customerInfo.state,
      'physicalZip': customerInfo.zipcode,
      'physicalLatitude': location.lat.toString(),
      'physicalLongitude': location.lng.toString(),
    };

    referralId = referral.toString();
    Map<String, dynamic> contactPreference = {
      'phone': contactByPhone,
      'email': contactByEmail,
      'rangeTime': contactRange,
      'promoInfobyEmail': promoInfobyEmail,
      'promoInfobySMS': promoInfoibySMS
    };
    Map<String, dynamic> ticketSelection = {
      'ticketTV': ticketTV,
      'ticketVoice': ticketVoice,
      'ticketServiceRequest': ticketServiceRequest,
    };

    List<Map<String, dynamic>> servicesList = [];
    for (Product product in services) {
      servicesList.add(product.toMap());
    }

    List<Map<String, dynamic>> servicesAdditionals = [];
    for (Product product in additionals) {
      servicesAdditionals.add(product.toMap());
    }

    List<Map<String, dynamic>> devicesList = [];
    for (Product product in devices) {
      devicesList.add(product.toMap());
    }

    List<Map<String, dynamic>> feesList = [];
    for (Product product in fees) {
      feesList.add(product.toMap());
    }

    List<Map<String, dynamic>> discountsList = [];
    for (Product product in discounts) {
      discountsList.add(product.toMap());
    }

    final Map<String, dynamic> body = {
      'apiKey': '3cBEFVR4qQleIRO2yWu0FcOCDdyZbuaU',
      'action': 'createServiceOrder',
      'customerType': customerInfo.serviceType,
      'networkType': customerInfo.coverageType,
      'locationGroup': customerInfo.locationGroup,
      'customer': customer,
      'contactPreference': contactPreference,
      'services': servicesList,
      'additionalServices': servicesAdditionals,
      'devices': devicesList,
      'fees': feesList,
      'discounts': discountsList,
      'engageOption': engageoption,
      'referralId': referralId,
    };
    print('ref $referralId');
    if (customerInfo.customerRep != '') {
      body['rep'] = customerInfo.customerRep;
      body['repTicketSelection'] = ticketSelection;
    }

    if (customerInfo.origin != '') {
      body['origin'] = customerInfo.origin;
    }

    if (portabilityCheck) {
      body['portabilityInfo'] = portabilityInfo;
      // print('datos de portability agregados exitosamente');
    }

    if (promos.isNotEmpty) {
      body['promo'] = promos;
      // print('datos de promos agregados exitosamente');
    }

    if (referralId.isNotEmpty) {
      body['referralId'] = referralId;
      print('Datos de referido agregados exitosamente');
    }
    try {
      if (origin.contains("social")) {
        js.context.callMethod('fbq', ['track', 'Lead']);
        // js.context['console'].callMethod(
        //     'log', ['Evento de Facebook Pixel Lead ejecutado por JS']);
      }

      var url = Uri.parse('$env/planbuilder/api');

      final response = await http.post(
        url,
        body: jsonEncode(body),
      );
      lockButton(true);
      // print(response.body);
      return response.body;
    } catch (e) {
      // print('ERROR - function createOrder(): $e');
      return 'Error';
    }
  }
}
