import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/additional_numbers_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/billing_telephone_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/current_provider_service_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/number_telephone_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/numbers_form_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/port_date_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/views/sign_view_form.dart';


class StepSelectorPortabilityFormView extends StatelessWidget {
  const StepSelectorPortabilityFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return Builder(builder: (context) {
    switch (selectorSummaryController.currentPortabilityView) {
      case StepsPortability.numberTelephoneView:
        return NumberTelephoneView(index: portabilityFormProvider.counterNumbersForm);
      case StepsPortability.billingTelephoneView:
        return BillingTelephoneView(index: portabilityFormProvider.counterNumbersForm);
      case StepsPortability.currentProviderView:
        return CurrentProviderServiceView(index: portabilityFormProvider.counterNumbersForm);
      case StepsPortability.portDateView:
        return PortDateView(index: portabilityFormProvider.counterNumbersForm);
      case StepsPortability.additionalNumbersView:
        return const AdditionalNumbersView();
      case StepsPortability.numbersFormView:
        return const NumbersFormView();
      case StepsPortability.signView:
        return const SignFormView();
      default:
        return NumberTelephoneView(index: portabilityFormProvider.counterNumbersForm);
      }
      });
  }
}
//Un cambio