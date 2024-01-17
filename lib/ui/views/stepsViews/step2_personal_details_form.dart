import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class Step2PersonalDetailsForm extends StatefulWidget {
  const Step2PersonalDetailsForm({Key? key})
      : super(key: key);

  @override
  State<Step2PersonalDetailsForm> createState() => _Step2PersonalDetailsFormState();
}

class _Step2PersonalDetailsFormState extends State<Step2PersonalDetailsForm> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;
  @override
  Widget build(BuildContext context) {
    final customerPDSDController = Provider.of<CustomerPDSDProvider>(context);
   final nameCharacters = RegExp(r'^(([A-Z]{1}|[ÁÉÍÓÚÑ]{1})[a-zá-ÿ]+[ ]?)+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    // final zcode = widget.zipcode.toString();
    var phoneFormat = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;

    

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        Icons.location_history_outlined,
                        color: colorInversePrimary,
                        size: isMobile ? 25 : 40,
                      ),
                    ),
                    Text(
                      'Personal Details',
                      style: TextStyle(
                        color: colorInversePrimary,
                        fontSize: isMobile ? 18 : 26,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Form(
            key: customerPDSDController.formKeyPD,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller:  customerPDSDController.parsedFNamePD,
                            onChanged: (value) {
                               customerPDSDController.activeNotifyListeners();
                            },
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            autocorrect: false,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            decoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'First Name*',
                                    icon: Icons.person_outlined,
                                    maxHeight: 55),
                    
                          validator: (value) {
                              return (nameCharacters.hasMatch(value ?? ''))
                              ? null
                              : 'Please enter your name, the name should be capitalized.';
                          },
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                        ),
                        const SizedBox(width: 15),
                        Flexible(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller:  customerPDSDController.parsedLNamePD,
                            onChanged: (value) {
                               customerPDSDController.activeNotifyListeners();
                            },
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            autocorrect: false,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            decoration: CustomInputs()
                                .formInputDecoration(
                                    label: 'Last Name*',
                                    icon: Icons.person_outlined,
                                    maxHeight: 55),
                    
                           validator: (value) {
                              return (nameCharacters.hasMatch(value ?? ''))
                              ? null
                              : 'Please enter your last name, the last name should be capitalized.';
                          },
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextFormField(
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedPhonePD,
                    
                          ///VALIDATION TRIGGER
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: CustomInputs()
                              .formInputDecoration(
                                  label: 'Phone Number*',
                                  icon: Icons.phone_outlined,
                                  maxHeight: 55),
                    
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(14),
                            phoneFormat
                          ],
                          validator: (value) {
                            return (phoneCharacters
                                        .hasMatch(value ?? '') &&
                                    value?.length == 14)
                                ? null
                                : 'Please enter a valid phone number';
                          },
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedEmailPD,
                    
                          ///VALIDATION TRIGGER
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: CustomInputs()
                              .formInputDecoration(
                                  label: 'E-mail Address*',
                                  icon: Icons.mail_outlined,
                                  maxHeight: 55),
                    
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            return regExp.hasMatch(value ?? '')
                                ? null
                                : 'Please enter a valid e-mail address';
                          },
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ])),
      ],
    );
  }
}
