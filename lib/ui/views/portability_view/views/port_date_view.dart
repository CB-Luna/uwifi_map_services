import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';

import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_date_time.dart';


class PortDateView extends StatelessWidget {
  final int index; 
  const PortDateView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 1000 ? true : false;
    return Form(
      key: portabilityFormProvider.portDateKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
    
          SizedBox(
            width: mobile ?  (size.width * 0.8) : 660,
            child: Card(
              color: Colors.white.withOpacity(0.7),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)),     
              child: Padding(
                padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5.0,
                        color: const Color(0xff2E5899),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('Step 4: Please provide your expected port date. Your porting date will not be less than 5 business days (Monday to Friday) from today.', 
                            style: GoogleFonts.workSans(
                                  color: const Color(0xffE0E4EC),
                                fontWeight: FontWeight.w600,
                                fontSize: mobile ? 15 : 22,
                            ),
                            textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      //Phone
                      Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            key: ValueKey(portabilityFormProvider.fields[index].keys.first),
                            children: [
                              Flexible(
                                child: CustomDateTime(index: index),
                              ),
                            ],
                          ),
                          // Text(telephoneNumber),
                        ]
                      )
                    ),
                      
                    ],
                  ),
                ),
              ),
          ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: CustomOutlinedButton(
                      onPressed: () {
                          if (portabilityFormProvider.validatePortDateForm()) {
                            selectorSummaryController.changePortabilityView(4);
                          }//
                      },
                      text: 'Continue'),
                ),
              ],
            ),
        ],
      ),
    );

      
  }

}