import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import '../../../providers/steps_controller.dart';

class CustomerPersonalDetailsForm extends StatelessWidget {
  const CustomerPersonalDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CustomerInfoProvider>(context);
    final stepsController = Provider.of<StepsController>(context);
    final customerInfo = Provider.of<CustomerInfoProvider>(context);
    final bool isRep = customerInfo.customerInfo.customerRep != '';

    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    // final zcode = widget.zipcode.toString();
    var phoneFormat = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 450,
          decoration: BoxDecoration(
            color: colorInversePrimary,
            boxShadow: const [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: -5,
                color: colorBgB,
                offset: Offset(0, 15),
              )
            ],
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_history_outlined,
                      color: colorPrimary,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Personal Details',
                      style: h2Style(context),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1.5,
                color: colorPrimaryDark,
              ),
              Flexible(
                child: Form(
                    key: stepsController.formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MediaQuery.of(context).size.width > 1130
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          /// VARIABLE STORAGE
                                          controller: controller.parsedFName,
                                          onChanged: (value) {
                                            controller.setfName(value);
                                            portabilityFormProvider
                                                .portFirstName = value;
                                          },

                                          ///VALIDATION TRIGGER
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          autocorrect: false,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          decoration: CustomInputs()
                                              .formInputDecoration(
                                                  label: 'First Name',
                                                  icon: Icons.person_outlined),

                                          validator: (value) {
                                            return validCharacters
                                                    .hasMatch(value ?? '')
                                                ? null
                                                : 'Please enter your name';
                                          },
                                          style: const TextStyle(
                                            color: colorPrimaryDark,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: TextFormField(
                                          /// VARIABLE STORAGE
                                          controller: controller.parsedLName,
                                          onChanged: (value) {
                                            controller.setlName(value);
                                            portabilityFormProvider
                                                .portLastName = value;
                                          },

                                          ///VALIDATION TRIGGER
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          autocorrect: false,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          decoration: CustomInputs()
                                              .formInputDecoration(
                                                  label: 'Last Name',
                                                  icon: Icons.person_outlined),

                                          validator: (value) {
                                            return validCharacters
                                                    .hasMatch(value ?? '')
                                                ? null
                                                : 'Please enter your name';
                                          },
                                          style: const TextStyle(
                                            color: colorPrimaryDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    height: 150,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              /// VARIABLE STORAGE
                                              controller:
                                                  controller.parsedFName,
                                              onChanged: (value) {
                                                controller.setfName(value);
                                                portabilityFormProvider
                                                    .portFirstName = value;
                                              },

                                              ///VALIDATION TRIGGER
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              autocorrect: false,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              decoration: CustomInputs()
                                                  .formInputDecoration(
                                                      label: 'First Name',
                                                      icon: Icons
                                                          .person_outlined),

                                              validator: (value) {
                                                return validCharacters
                                                        .hasMatch(value ?? '')
                                                    ? null
                                                    : 'Please enter your name';
                                              },
                                              style: const TextStyle(
                                                color: colorPrimaryDark,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: TextFormField(
                                              /// VARIABLE STORAGE
                                              controller:
                                                  controller.parsedLName,
                                              onChanged: (value) {
                                                controller.setlName(value);
                                                portabilityFormProvider
                                                    .portLastName = value;
                                              },

                                              ///VALIDATION TRIGGER
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              autocorrect: false,
                                              obscureText: false,
                                              keyboardType: TextInputType.name,
                                              decoration: CustomInputs()
                                                  .formInputDecoration(
                                                      label: 'Last Name',
                                                      icon: Icons
                                                          .person_outlined),

                                              validator: (value) {
                                                return validCharacters
                                                        .hasMatch(value ?? '')
                                                    ? null
                                                    : 'Please enter your name';
                                              },
                                              style: const TextStyle(
                                                color: colorPrimaryDark,
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                            TextFormField(
                              /// VARIABLE STORAGE
                              controller: controller.parsedPhone,
                              onChanged: (value) => controller.setPhone(value),

                              ///VALIDATION TRIGGER
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              decoration: CustomInputs().formInputDecoration(
                                  label: 'Phone Number',
                                  icon: Icons.phone_outlined),

                              inputFormatters: [
                                LengthLimitingTextInputFormatter(14),
                                phoneFormat
                              ],
                              validator: (value) {
                                return (phoneCharacters.hasMatch(value ?? '') &&
                                        value?.length == 14)
                                    ? null
                                    : 'Please enter a valid phone number';
                              },
                              style: const TextStyle(
                                color: colorPrimaryDark,
                              ),
                            ),
                            TextFormField(
                              /// VARIABLE STORAGE
                              controller: controller.parsedEmail,
                              onChanged: (value) {
                                controller.setEmail(value);
                                portabilityFormProvider.portEmail = value;
                              },

                              ///VALIDATION TRIGGER
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: CustomInputs().formInputDecoration(
                                  label: 'E-mail Address',
                                  icon: Icons.mail_outlined),

                              validator: (value) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                return regExp.hasMatch(value ?? '')
                                    ? null
                                    : 'Please enter a valid e-mail address';
                              },
                              style: const TextStyle(
                                color: colorPrimaryDark,
                              ),
                            ),
                          ]),
                    )),
              ),
            ],
          ),
        ),
        if (isRep) const SizedBox(height: 30),
        if (isRep)
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FF),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: -5,
                  color: Color(0x506FA5DB),
                  offset: Offset(0, 15),
                )
              ],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(35, 35, 35, 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Disclaimers',
                        style: GoogleFonts.getFont('Work Sans',
                            color: colorPrimaryDark,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: -0.5),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      '* Install cannot be guaranteed until the technician completes a site survey and provide options for service.',
                      style: GoogleFonts.getFont(
                        'Work Sans',
                        color: const Color(0xFFD20030),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(
                      '* Installation fees may apply to the order. The representative will provide these fees when you are contacted.',
                      style: GoogleFonts.getFont(
                        'Work Sans',
                        color: const Color(0xFFD20030),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
