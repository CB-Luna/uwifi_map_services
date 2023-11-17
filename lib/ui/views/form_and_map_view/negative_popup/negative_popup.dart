import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/negative_popup/first_step.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/negative_popup/second_step.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/negative_popup/third_step.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'rep_exception_flow/location_extra_step.dart';
import 'rep_exception_flow/location_step.dart';
import 'rep_exception_flow/service_step.dart';
import 'rep_exception_flow/technology_step.dart';

class NegativePopup extends StatelessWidget with Popup {
  final CustomerInfo customerInfo;
  const NegativePopup({Key? key, required this.customerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return PointerInterceptor(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(0),
        content: ChangeNotifierProvider<PopupController>(
          create: (_) => PopupController(customerInfo: customerInfo),
          child: Container(
            constraints: getConstraints(
              context: context,
              height: 550,
              width: 650,
            ),
            decoration: buildBoxDecoration(image: 'images/bg_gradient.png', fit: BoxFit.cover),
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        splashRadius: 15.0,
                        padding: const EdgeInsets.all(12.0),
                        icon: const Icon(
                          Icons.close,
                          color: colorInversePrimary,
                          size: 20,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Builder(builder: (context) {
                      final controller = Provider.of<PopupController>(context);

                      switch (controller.step) {
                        case Steps.firstStep:
                          // return !(customerInfo.customerRep != "")
                          //     ?
                          //Si no es customer representative, automáticamente pasa al paso para recibir los datos.
                          // const SecondStep()
                          return FirstStep(customerInfo: customerInfo);
                        case Steps.secondStep:
                          return SecondStep(customerInfo: customerInfo);
                        case Steps.thirdStep:
                          return const ThirdStep();

                        case Steps.firstExcepStep:
                          return const LocationStep();

                        case Steps.firstExcepExtraStep:
                          return const LocationExtraStep();

                        case Steps.secondExcepStep:
                          return const TechnologyStep();

                        case Steps.thirdExcepStep:
                          return const ServiceStep();

                        default:
                          return FirstStep(customerInfo: customerInfo);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
