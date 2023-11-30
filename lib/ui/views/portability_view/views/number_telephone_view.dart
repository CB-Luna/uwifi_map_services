import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';

import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_inputs.dart';

class NumberTelephoneView extends StatelessWidget {
  final int index;
  const NumberTelephoneView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 1000 ? true : false;
    return Form(
      key: portabilityFormProvider.telephoneNumberKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: mobile ? (size.width * 0.8) : 660,
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
                          child: Text(
                            'Step 1: Please provide the phone number on your existing phone account that you want to port to RTA.',
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
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            key: ValueKey(portabilityFormProvider
                                .fields[index].keys.first),
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: portabilityFormProvider
                                      .telephoneNumberController[index],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    // phoneFormat
                                  ],
                                  onChanged: (value) {
                                    portabilityFormProvider
                                        .changeValueTelephoneNumber(index);
                                  },
                                  validator: (value) {
                                    return (phoneCharacters
                                                .hasMatch(value ?? '') &&
                                            value?.length == 10)
                                        ? null
                                        : 'Enter a valid phone number';
                                  },
                                  style:
                                      const TextStyle(color: Color(0xff324057)),
                                  decoration: CustomInputs.formInputDecoration(
                                    label: 'Telephone Number ${index + 1}',
                                    icon: Icons.local_phone_outlined,
                                    //maxWidth: 119
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Text(telephoneNumber),
                        ])),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
