

import 'package:flutter/material.dart';

class CustomerShippingInfo with ChangeNotifier {
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

  String lastName = '';
  String firstName = '';
  String phone = '';
  String address = '';
  String address2 = '';
  
  String custEmail = '';

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
}