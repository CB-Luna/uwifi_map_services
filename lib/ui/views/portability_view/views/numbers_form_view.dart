import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_date_time.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_inputs.dart';

class NumbersFormView extends StatelessWidget {
  const NumbersFormView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 910 ? true : false;

    return Form(
      key: portabilityFormProvider.numbersFormKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: size.width < 1000 ? (size.width * 0.8) : 700,
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
                              'Modify or edit your numbers to port and your current service provider',
                              style: GoogleFonts.workSans(
                                color: const Color(0xffE0E4EC),
                                fontWeight: FontWeight.w600,
                                fontSize: mobile ? 16 : 22,
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
                            for (var index = 0;
                                index < portabilityFormProvider.fields.length;
                                index++)
                              Row(
                                key: ValueKey(portabilityFormProvider
                                    .fields[index].keys.first),
                                children: [
                                  Flexible(
                                    flex: 8,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: TextFormField(
                                              controller: portabilityFormProvider
                                                      .telephoneNumberController[
                                                  index],
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              onChanged: (value) {
                                                portabilityFormProvider
                                                    .changeValueTelephoneNumber(
                                                        index);
                                              },
                                              validator: (value) {
                                                return (phoneCharacters
                                                            .hasMatch(
                                                                value ?? '') &&
                                                        value?.length == 10)
                                                    ? null
                                                    : 'Enter a valid phone number';
                                              },
                                              style: const TextStyle(
                                                  color: Color(0xff324057)),
                                              decoration: CustomInputs
                                                  .formInputDecoration(
                                                label:
                                                    'Telephone Number ${index + 1}',
                                                icon:
                                                    Icons.local_phone_outlined,
                                                //maxWidth: 119
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          //Billing telephone
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: TextFormField(
                                              controller: portabilityFormProvider
                                                      .billingTelephoneController[
                                                  index],
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                              ],
                                              onChanged: (value) {
                                                // portabilityFormProvider.billingTelephone[index] = value;
                                                portabilityFormProvider
                                                    .changeValueBillingTelephone(
                                                        index);
                                              },
                                              validator: (value) {
                                                return (phoneCharacters
                                                            .hasMatch(
                                                                value ?? '') &&
                                                        value?.length == 10)
                                                    ? null
                                                    : 'Enter a valid phone number';
                                              },
                                              style: const TextStyle(
                                                  color: Color(0xff324057)),
                                              decoration: CustomInputs
                                                  .formInputDecoration(
                                                label:
                                                    'Billing Telephone ${index + 1}',
                                                icon:
                                                    Icons.local_phone_outlined,
                                                //maxWidth: 119
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(height: 3,),
                                          mobile
                                              ? SizedBox(
                                                  width: size.width * 0.8,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: TextFormField(
                                                          readOnly: index > 0
                                                              ? true
                                                              : false,
                                                          enabled: index > 0
                                                              ? false
                                                              : true,
                                                          autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                          controller:
                                                              portabilityFormProvider
                                                                  .currentServiceController,
                                                          onChanged: (value) {
                                                            portabilityFormProvider
                                                                .changeValueCurrentServiceProvider();
                                                          },
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Enter a service provider';
                                                            }
                                                            return null;
                                                          },
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xff324057)),
                                                          decoration: CustomInputs
                                                              .formInputDecoration(
                                                            label:
                                                                'Current Service Provider',
                                                            icon: Icons
                                                                .phone_outlined,
                                                            //maxWidth: 20
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      //Request port dates
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: CustomDateTime(
                                                            index: index),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 90,
                                                  child: Row(children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        readOnly: index > 0
                                                            ? true
                                                            : false,
                                                        enabled: index > 0
                                                            ? false
                                                            : true,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        controller:
                                                            portabilityFormProvider
                                                                .currentServiceController,
                                                        onChanged: (value) {
                                                          portabilityFormProvider
                                                              .changeValueCurrentServiceProvider();
                                                        },
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Enter a service provider';
                                                          }
                                                          return null;
                                                        },
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xff324057)),
                                                        decoration: CustomInputs
                                                            .formInputDecoration(
                                                          label:
                                                              'Current Service Provider',
                                                          icon: Icons
                                                              .phone_outlined,
                                                          //maxWidth: 20
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    //Request port dates
                                                    Expanded(
                                                      child: CustomDateTime(
                                                          index: index),
                                                    ),
                                                  ]),
                                                ),
                                        ]),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          index > 0
                                              ?
                                              //Remove botton
                                              Container(
                                                  height: mobile ? 30 : 35,
                                                  width: mobile ? 30 : 35,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                    border: Border.all(
                                                      color: Colors.red,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: IconButton(
                                                    splashRadius: 15.0,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    iconSize: 18,
                                                    color: Colors.red,
                                                    icon: const Icon(
                                                        Icons.remove),
                                                    onPressed: () {
                                                      portabilityFormProvider
                                                          .removeTextEditingControllers(
                                                              index);
                                                      portabilityFormProvider
                                                          .removeFromListString(
                                                              index);
                                                      portabilityFormProvider
                                                          .removeField(index);
                                                      portabilityFormProvider
                                                          .counterNumbersForm--;
                                                    },
                                                  ),
                                                )
                                              : const SizedBox(),

                                          index > 0
                                              ? const SizedBox(height: 20)
                                              : const SizedBox(),

                                          // //Add botton
                                          Visibility(
                                            visible: index ==
                                                portabilityFormProvider
                                                        .fields.length -
                                                    1,
                                            child: Container(
                                              height: mobile ? 30 : 35,
                                              width: mobile ? 30 : 35,
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25.0)),
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: IconButton(
                                                splashRadius: 15.0,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                iconSize: 18,
                                                color: Colors.green,
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  if (portabilityFormProvider
                                                      .validateNumbersForm()) {
                                                    if (portabilityFormProvider
                                                            .counterNumbersForm <
                                                        11) {
                                                      portabilityFormProvider
                                                          .addField();
                                                      portabilityFormProvider
                                                          .addTextEditingControllers();
                                                      portabilityFormProvider
                                                          .counterNumbersForm++;
                                                    } else {
                                                      Flushbar(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFFD20030),
                                                        message:
                                                            "You can't add more numbers, you reached the limit of numbers to port",
                                                        duration:
                                                            const Duration(
                                                                seconds: 4),
                                                      ).show(context);
                                                    }
                                                  } //Aquie estan los unique identifier
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            // Text(telephoneNumber),
                          ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
