import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';

class PopAgreePortabilityService extends StatelessWidget {
  const PopAgreePortabilityService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final cartController = Provider.of<Cart>(context);
    return Container(
            padding: const EdgeInsets.all(10),
            width: 660,
            height: mobile ? 500 : 360,
            decoration: buildBoxDecoration(image: 'images/bg_gradient.png'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  'You chose Voice Service of RTA',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 18 : 28,
                    height: 1,
                    color: const Color(0xff2E5899),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Would you like to move (port) the telephone number you are already using with your current provider to RTA gigFAST VoIP service?',
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 15 : 23,
                    color: const Color(0xff001E4D),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '*Note: Please have an electronic copy of your last telephone bill with your name, all telephone numbers being ported, and the account number in pdf format or image (jpg/png).',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xff001E4D),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Center(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: [
                      CustomOutlinedButton(
                            onPressed: () {
                              selectorSummaryController.changeView(1);
                            },
                            text: "Yes, I'd like",
                            bgColor: const Color(0xff2E5899),
                            borderColor: const Color(0xff2E5899),
                          ),
                      CustomOutlinedButton(
                            onPressed: () {
                              portabilityFormProvider.clearInformationPortability();
                              portabilityFormProvider.portabilityCheck = false;
                              Navigator.of(context).pop();
                              },
                            text: 'No',
                            bgColor: const Color(0xFFD20030),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
  }

  BoxConstraints getConstraints({context, width, height}) {
    final size = MediaQuery.of(context).size;
    //550, 650
    if (size.height > height && size.width > width) {
      return BoxConstraints(minHeight: height * 0.9, minWidth: width * 0.9);
    } else {
      return const BoxConstraints();
    }
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}