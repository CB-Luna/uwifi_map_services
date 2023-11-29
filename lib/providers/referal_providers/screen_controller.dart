import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ui/views/portability_view/popups/pop_referral_added.dart';
import '../../ui/views/portability_view/popups/popup_initial.dart';
import 'portability_form_provider_r.dart';

enum Views { homeView, formView }

class ScreenController with ChangeNotifier {
  Views _index = Views.homeView;
  bool promoCheckFlag = false;
  bool formValidated = false;

  Views get currentStep => _index;

  set currentStep(index) {
    _index = index;

    notifyListeners();
  }

  validateScreen(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProviderR>(context, listen: false);

    switch (currentStep) {
      case Views.homeView:
        //  selectorSummaryview(context);
        portabilityFormProvider.totalOptions > 1
            ? popUpInitial(context)
            : popUpReferralAddedd(context);
        currentStep = Views.formView;
        break;
      case Views.formView:
        break;
    }

    notifyListeners();
  }
}
