import 'package:flutter/material.dart';

enum Steps {agreePortView, lastBillView, namePortView, newFormNamePortView, addressPortView, newFormAddressPortView, portabilityView, finalPortView, cameraView, formView }

enum StepsPortability {numberTelephoneView, billingTelephoneView, currentProviderView, portDateView, numbersFormView, additionalNumbersView, signView}

enum MobilePortability {portMobileView, contractView}

enum MobileSignPortability {listView, segmentContractView}

class SelectorSummaryController  extends ChangeNotifier {

 Steps currentSummaryView = Steps.agreePortView;

 StepsPortability currentPortabilityView = StepsPortability.numberTelephoneView;

 MobilePortability currentPortMobileView = MobilePortability.portMobileView;

 MobileSignPortability currentPortSignMobileView = MobileSignPortability.listView;

  void changeView(int step) {
    switch (step) {
      case 0:
        currentSummaryView = Steps.agreePortView;
        break;
      case 1:
        currentSummaryView = Steps.lastBillView;
        break;
      case 2:
        currentSummaryView = Steps.namePortView;
        break;
      case 3:
        currentSummaryView = Steps.newFormNamePortView;
        break;
      case 4:
        currentSummaryView = Steps.addressPortView;
        break;
      case 5:
        currentSummaryView = Steps.newFormAddressPortView;
        break;
      case 6:
        currentSummaryView = Steps.portabilityView;
        break;
      case 7:
        currentSummaryView = Steps.finalPortView;
        break;
      case 8:
        currentSummaryView = Steps.cameraView;
        break;
         case 9:
        currentSummaryView = Steps.formView;
        break;
      default:
        currentSummaryView = Steps.agreePortView;
        break;
    }
    notifyListeners();
  }

  void changePortabilityView(int step) {
    switch (step) {
      case 0:
        currentPortabilityView = StepsPortability.numberTelephoneView;
        break;
      case 1:
        currentPortabilityView = StepsPortability.billingTelephoneView;
        break;
      case 2:
        currentPortabilityView = StepsPortability.currentProviderView;
        break;
      case 3:
        currentPortabilityView = StepsPortability.portDateView;
        break;
      case 4:
        currentPortabilityView = StepsPortability.additionalNumbersView;
        break;
      case 5:
        currentPortabilityView = StepsPortability.numbersFormView;
        break;
      case 6:
        currentPortabilityView = StepsPortability.signView;
        break;
      default:
        currentPortabilityView = StepsPortability.numberTelephoneView;
        break;
    }
    notifyListeners();
  }

  void changePortabilityMobileView(int step) {
    switch (step) {
      case 0:
        currentPortMobileView = MobilePortability.portMobileView;
        break;
      case 1:
        currentPortMobileView = MobilePortability.contractView;
        break;
      default:
        currentPortMobileView = MobilePortability.portMobileView;
        break;
    }
    notifyListeners();
  }

  void changePortabilitySignMobileView(int step) {
    switch (step) {
      case 0:
        currentPortSignMobileView = MobileSignPortability.listView;
        break;
      case 1:
        currentPortSignMobileView = MobileSignPortability.segmentContractView;
        break;
      default:
        currentPortSignMobileView = MobileSignPortability.listView;
        break;
    }
    notifyListeners();
  }
}
