import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/smi_popup/second_step.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/smi_popup/third_step.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../negative_popup/first_step.dart';

class SmiPopup extends StatelessWidget with Popup {
  final CustomerInfo customerInfo;
  const SmiPopup({Key? key, required this.customerInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            decoration: buildBoxDecoration(image: 'images/bg_gradient.png'),
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
                      color: Color(0xff8aa7d2),
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Builder(builder: (context) {
                  final controller = Provider.of<PopupController>(context);
                  switch (controller.step) {
                    case Steps.firstStep:
                      return const FirstStep();
                    case Steps.secondStep:
                      return const SecondStep();
                    case Steps.thirdStep:
                      return const ThirdStep();
                    default:
                      return const FirstStep();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
