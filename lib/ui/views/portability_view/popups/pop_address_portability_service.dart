import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';

class PopAddressPortabilityService extends StatelessWidget {
  const PopAddressPortabilityService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return Container(
            padding: const EdgeInsets.all(10),
            height: 340,
            width: 660,
            decoration: buildBoxDecoration(image: 'images/blue_circles.png'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    'Portability Data Validation',
                    style: GoogleFonts.poppins(
                      fontSize: mobile ? 20 : 30,
                      height: 1.2,
                      color: const Color(0xff2E5899),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                RichText(
                    text: TextSpan( 
                      style: GoogleFonts.poppins(
                        fontSize: mobile ? 18 : 25,
                        height: 1,
                        color: const Color(0xff001E4D),
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        const TextSpan(text: 'Is '),
                        TextSpan(text: "'${portabilityFormProvider.portNumberStreet}, ${portabilityFormProvider.portZipcode}, ${portabilityFormProvider.portCity}, ${portabilityFormProvider.portState}' ", 
                          style: GoogleFonts.poppins(
                          fontSize: mobile ? 18 : 25,
                          height: 1,
                          color: const Color(0xff001E4D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        const TextSpan(text: 'the same address on your current phone providers account/invoice?'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                Center(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: [
                      CustomOutlinedButton(
                            onPressed: () {
                              selectorSummaryController.changeView(6);
                            },
                            text: 'Yes',
                            bgColor: const Color(0xff2E5899),
                            borderColor: const Color(0xff2E5899),
                          ),
                      CustomOutlinedButton(
                            onPressed: () {
                              selectorSummaryController.changeView(5);
                            },
                            text: 'No',
                            bgColor: const Color(0xFFD20030),
                          ),
                    ],
                  ),
                ),
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