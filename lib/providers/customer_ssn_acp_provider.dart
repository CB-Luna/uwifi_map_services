import 'package:flutter/material.dart';
class CustomerSSNACPProvider with ChangeNotifier {

  //Remember my ACP Number
  bool acpNumberR = false;
  // ACP Number
  final TextEditingController acpNumber = TextEditingController(text: "");
  // SSN Lat 4 digits
  final TextEditingController ssn4LD = TextEditingController(text: "");

  final TextEditingController parsedFName = TextEditingController();
  final TextEditingController parsedLName = TextEditingController();
  final TextEditingController parsedPhone = TextEditingController();
  final TextEditingController parsedEmail = TextEditingController();
  final TextEditingController parsedAddress = TextEditingController();
  //controllers for the Card Info
  final TextEditingController parsedName = TextEditingController();

  GlobalKey<FormState> formKeySSNACP = GlobalKey<FormState>();

  bool formValidationSSNACP() {
    return (formKeySSNACP.currentState!.validate()) ? true : false;
  }

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

  void changeRemeberACPNumber() {
    acpNumberR = !acpNumberR;
    notifyListeners();
  }

}
