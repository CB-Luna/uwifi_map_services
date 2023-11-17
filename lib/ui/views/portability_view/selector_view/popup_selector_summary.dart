import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_address_portability_service.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_upload_last_bill.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_agree_portability_service.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_final_portability_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_name_portability_service.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_new_form_address_portability.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_new_form_name_portability.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_portability_already_done.dart';
import 'package:uwifi_map_services/ui/views/portability_view/screens/camera_screen.dart';
import 'package:uwifi_map_services/ui/views/portability_view/selector_view/step_selector_portability_form_view.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/portability.dart';


class PopupSelectorSummary extends StatelessWidget {
  const PopupSelectorSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(0),
        content: ChangeNotifierProvider<SelectorSummaryController>(
        create: (_) => SelectorSummaryController(),
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Builder(builder: (context) {
                  final controller = Provider.of<SelectorSummaryController>(context);
                   switch  (controller.currentSummaryView) {
                      case Steps.agreePortView:
                        return const PopAgreePortabilityService();
                      case Steps.lastBillView:
                        return portabilityFormProvider.portabilityCheck ? const PopPortabilityAlreadyDone() : const PopUploadLastBill();
                      case Steps.namePortView:
                        return const PopNamePortabilityService();
                      case Steps.newFormNamePortView:
                        return const PopNewFormNamePortability();
                      case Steps.addressPortView:
                        return const PopAddressPortabilityService();
                      case Steps.newFormAddressPortView:
                        return const PopNewFormAddressPortability();
                      case Steps.portabilityView:
                        return const Portability(child: StepSelectorPortabilityFormView());
                      case Steps.finalPortView:
                        return const PopFinalPortabilityView();
                      case Steps.cameraView:
                        return const CameraScreen();
                      default:
                        return const PopAgreePortabilityService();
                    }
                  }),
          ),
          ),
      );
  }
}