import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';

import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';


class AdditionalNumbersView extends StatelessWidget {
  const AdditionalNumbersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 800 ? true : false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Would you like to port additional numbers?',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 20 : 25,
            height: 1.5,
            color: const Color(0xff001E4D),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 25,
          children: [
            CustomOutlinedButton(
                  onPressed: () {
                    if (portabilityFormProvider.counterNumbersForm < 12)
                    {
                      portabilityFormProvider.addField();
                      portabilityFormProvider.addTextEditingControllers();
                      portabilityFormProvider.counterNumbersForm++; 
                      selectorSummaryController.changePortabilityView(0); 
                    }
                    else{
                      Flushbar(
                        backgroundColor: const Color(0xFFD20030),
                        message: "You can't add more numbers, you reached the limit of numbers to port",
                        duration: const Duration(seconds: 4),
                      ).show(context);
                    } 
                  },
                  text: 'Yes',
                  bgColor: const Color(0xff2E5899),
                  borderColor: const Color(0xff2E5899),
                ),
            mobile ? 
            CustomOutlinedButton(
                  onPressed: () {
                    selectorSummaryController.changePortabilityView(6);
                    },
                  text: 'No',
                  bgColor: const Color(0xFFD20030),
                )
            :
            CustomOutlinedButton(
                  onPressed: () {
                    portabilityFormProvider.scrollDown();
                    selectorSummaryController.changePortabilityView(6);
                    },
                  text: 'No',
                  bgColor: const Color(0xFFD20030),
                ),
          ],
        ),
      ],
    );
      
  }

}