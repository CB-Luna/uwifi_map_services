// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/classes/validate_loa_signed.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option_portability.dart';
import 'package:uuid/uuid.dart';

class PortabilityFormProvider extends ChangeNotifier {
  GlobalKey<FormState> telephoneNumberKey = GlobalKey<FormState>();
  GlobalKey<FormState> billingTelephoneKey = GlobalKey<FormState>();
  GlobalKey<FormState> currentProviderKey = GlobalKey<FormState>();
  GlobalKey<FormState> portDateKey = GlobalKey<FormState>();
  GlobalKey<FormState> numbersFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> newFormNameKey = GlobalKey<FormState>();
  GlobalKey<FormState> newFormAddressKey = GlobalKey<FormState>();
  GlobalKey<FormState> upLoadBillKey = GlobalKey<FormState>();

  final ScrollController scrollControllerLetter = ScrollController();

  void scrollDown() {
    scrollControllerLetter.animateTo(
      scrollControllerLetter.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }

  PortabilityFormProvider() {
    addTelephoneNumberController();
    addBillingTelephoneController();
    addField();
  }
  String email = '';
  String name = '';
  String address = '';
  String city = '';
  String state = '';
  String zipcode = '';

  //SignForm
  bool fileSelected = false;
  String fileName = "";
  late Uint8List fileBytes;
  //New Form
  String portFirstName = '';
  String portLastName = '';
  String portNumberStreet = '';
  String portCity = '';
  String portState = '';
  String portZipcode = '';
  String formattedDate = '';
  String portEmail = '';
  String portInitials = '';

  bool portabilityCheck = false;
  DateTime dateNow = DateTime.now();

  int counterNumbersForm = 0;
  final List<Map<String, String>> fields = [];

  //TextControllers
  List<TextEditingController> telephoneNumberController = [];
  List<TextEditingController> billingTelephoneController = [];
  TextEditingController requestedPortDateController = TextEditingController();
  TextEditingController currentServiceController = TextEditingController();

  List<String> telephoneNumber = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  List<String> billingTelephone = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  String requestedPortDate = '';
  String currentServiceProvider = '';

  //Response Letter
  bool availableContinue = false;
  Product portabilityVoice = Product(
    id: 'phoneNumberPort',
    name: 'Phone Number Port',
    cost: double.parse('5.00'),
    service: 'VoiceAdditional',
    category: 'gigFastVoice',
    index: 0,
    isSelected: true,
    quantity: 1,
    pwName: 'Phone Number Port',
  );

  //mobile Version
  int indexContainer = 0;

  void changeButtons(bool boolean) {
    availableContinue = boolean;
    notifyListeners();
  }

  void addField() {
    fields.add({const Uuid().v1(): ''});
    print("Add Fields: ${fields.length}");
    notifyListeners();
  }

  void removeField(int index) {
    fields.removeAt(index);
    print("Remove Fields: ${fields.length}");
    notifyListeners();
  }

  void addTextEditingControllers() {
    addTelephoneNumberController();
    addBillingTelephoneController();
    notifyListeners();
  }

  void removeFromListString(int index) {
    telephoneNumber.removeAt(index);
    billingTelephone.removeAt(index);
    telephoneNumber.add('');
    billingTelephone.add('');
    notifyListeners();
  }

  void removeTextEditingControllers(int index) {
    telephoneNumberController.removeAt(index);
    billingTelephoneController.removeAt(index);
    notifyListeners();
  }

  void addTelephoneNumberController() {
    TextEditingController textEditingTNController = TextEditingController();
    telephoneNumberController.add(textEditingTNController);
  }

  void addBillingTelephoneController() {
    TextEditingController textEditingBTController = TextEditingController();
    billingTelephoneController.add(textEditingBTController);
  }

  void changeValueTelephoneNumber(int index) {
    telephoneNumber[index] = telephoneNumberController[index].text;
    notifyListeners();
  }

  void changeValueBillingTelephone(int index) {
    billingTelephone[index] = billingTelephoneController[index].text;
    notifyListeners();
  }

  void changeValueRequestedPortDate() {
    requestedPortDate = requestedPortDateController.text;
    notifyListeners();
  }

  void changeValueCurrentServiceProvider() {
    currentServiceProvider = currentServiceController.text;
    notifyListeners();
  }

  bool validateNumbersForm() {
    return numbersFormKey.currentState!.validate() ? true : false;
  }

  bool validateTelephoneNumberForm() {
    return telephoneNumberKey.currentState!.validate() ? true : false;
  }

  bool validateBillingTelephoneForm() {
    return billingTelephoneKey.currentState!.validate() ? true : false;
  }

  bool validateCurrentProviderForm() {
    return currentProviderKey.currentState!.validate() ? true : false;
  }

  bool validatePortDateForm() {
    return portDateKey.currentState!.validate() ? true : false;
  }

  bool validateSignForm() {
    return signFormKey.currentState!.validate() ? true : false;
  }

  bool validateNewFormName() {
    return newFormNameKey.currentState!.validate() ? true : false;
  }

  bool validateNewFormAddress() {
    return newFormAddressKey.currentState!.validate() ? true : false;
  }

  bool validateFormUploadBill() {
    return upLoadBillKey.currentState!.validate() ? true : false;
  }

  String getFormattedDateNow() {
    formattedDate = DateFormat("MM/dd/yyyy").format(dateNow);
    return formattedDate;
  }

  void selectedOptionsPortability(int index) {
    for (int i = 0; i < optionsPortability.length; i++) {
      if (index == i) {
        optionsPortability[i].isSelected = true;
        indexContainer = index;
      } else {
        optionsPortability[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  void clearInformationPortability() {
    final maxFields = fields.length;
    telephoneNumber = ['', '', '', '', '', '', '', '', '', '', '', ''];
    billingTelephone = ['', '', '', '', '', '', '', '', '', '', '', ''];
    requestedPortDate = '';
    currentServiceProvider = '';
    for (var i = 0; i < maxFields; i++) {
      telephoneNumberController[i].clear();
      billingTelephoneController[i].clear();
      if (i != 0) {
        removeField(i);
      }
    }
    requestedPortDateController.clear();
    currentServiceController.clear();
    fileSelected = false;
    availableContinue = false;
    counterNumbersForm = 0;
    indexContainer = 0;
    notifyListeners();
  }

  void pickFiles() async {
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png']);
    checkFileName(result);
  }

  void checkFileName(result) {
    if (result != null) {
      fileSelected = true;
      fileName = result.files.first.name;
      fileBytes = result.files.first.bytes;
      // Upload file
      //await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
    } else {
      fileSelected = false;
      fileName = '';
    }
    notifyListeners();
  }

  void cleanLastBillFile() {
    fileSelected = false;
    fileBytes.clear();
    fileName = "";
    notifyListeners();
  }

  void changeLastBillFile(String xFileName, Uint8List bytes) {
    fileSelected = true;
    fileBytes = bytes;
    fileName = "LastBillPicture.jpeg";
    notifyListeners();
  }

  Future<bool> getDocumentLOAPortability(String email) async {
    try {
      var url = Uri.parse('$env/planbuilder/api');

      final bodyMsg = jsonEncode({
        "apikey": "svsvs54sef5se4fsv",
        "action": "validateLOASigned",
        "email": email
      });

      var response = await http.post(url, body: bodyMsg);

      var validateLOASigned = ValidateLOASigned.fromJson(response.body);

      if (validateLOASigned.result == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('ERROR - function getDocumentLOAPortability(): $e');
      return false;
    }
  }

  send() async {
    var url = Uri.parse('https://en8owucj1koz7xi.m.pipedream.net');
    var response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${json.decode(response.body)}');
    // print(
    //     '$email - $name - $address - $city - $state - $zipcode $currentServiceProvider - $phonePorts');
  }

  uploadFileLastBill() {
    print("+++FileName: $fileName");
    print("+++FileBytes: $fileBytes");
    Map<String, String> headers = {};
    var postUri =
        Uri.parse('$env/planbuilder/port/upload/$portEmail/$fileName');
    var request = http.MultipartRequest("POST", postUri);
    //add file to request
    request.files.add(http.MultipartFile.fromBytes('file', fileBytes));
    //add headers
    request.headers.addAll(headers);
    //send request
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");

      print("****** Status Code:  ${response.statusCode} *********");
    });
  }
}

// https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code