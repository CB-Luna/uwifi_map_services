import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/inputs/custom_checkbox.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

import '../../../../providers/tracking_provider.dart';

class SecondStep extends StatelessWidget {
  final CustomerInfo? customerInfo;

  const SecondStep({
    Key? key,
    this.customerInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final controller = Provider.of<PopupController>(context);
    var phoneFormat = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');

    final List<Widget> checkboxes = [
      FractionallySizedBox(
        widthFactor: mobile ? 1 : 0.45,
        child: CustomCheckbox(
          value: controller.emailCheckbox,
          onChanged: controller.setEmailCheckbox,
          text:
              'I would like to receive promotional messages from RTA by E-mail',
        ),
      ),
      FractionallySizedBox(
        widthFactor: mobile ? 1 : 0.45,
        child: CustomCheckbox(
          value: controller.smsCheckbox,
          onChanged: controller.setSmsCheckbox,
          text: 'I would like to receive promotional messages from RTA by SMS',
        ),
      ),
    ];

    final tracking = Provider.of<TrackingProvider>(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We were unable to determine if we can serve your address at this time.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                color: const Color(0xffD20030),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Please provide your name and contact information and so we can reach out to you with more information on availability.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                letterSpacing: 0.25,
                color: const Color.fromARGB(255, 103, 139, 192),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        //first name
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) => controller.firstName = value,
                            validator: (value) {
                              final RegExp regex =
                                  RegExp(r"^\s*[a-zA-Z ,.'-]+\s*$");
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              } else if (!regex.hasMatch(value)) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color(0xff324057)),
                            decoration: CustomInputs().formInputDecoration(
                              label: 'First Name',
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        //last name
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (value) => controller.lastName = value,
                            validator: (value) {
                              final RegExp regex =
                                  RegExp(r"^\s*[a-zA-Z ,.'-]+\s*$");
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name';
                              } else if (!regex.hasMatch(value)) {
                                return 'Please enter a valid name';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color(0xff324057)),
                            decoration: CustomInputs().formInputDecoration(
                              label: 'Last Name',
                              icon: Icons.person_outline_rounded,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //phone
                    TextFormField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => controller.phone = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      style: const TextStyle(color: Color(0xff324057)),
                      decoration: CustomInputs().formInputDecoration(
                        label: 'Phone Number',
                        icon: Icons.local_phone_outlined,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //email
                    TextFormField(
                      controller: controller.emailController,
                      onChanged: (value) => controller.email = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Color(0xff324057)),
                      decoration: CustomInputs().formInputDecoration(
                        label: 'Email',
                        icon: Icons.email_outlined,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            mobile
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: checkboxes,
                  )
                : Wrap(
                    alignment: WrapAlignment.center,
                    children: checkboxes,
                  ),
            const SizedBox(height: 10),
            CustomOutlinedButton(
              onPressed: () async {
                if (controller.validateForm()) {
                  await controller.createLead();
                  controller.changeStep();

                  if (customerInfo != null) {
                    if (!(customerInfo!.customerRep != "")) {
                      tracking.recordTrack(
                          view: "NoCoverageSubmit",
                          firstName: controller.firstName,
                          lastName: controller.lastName,
                          email: controller.email);
                    }
                  }
                }
              },
              text: 'Submit',
              bgColor: const Color(0xFFD20030),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
