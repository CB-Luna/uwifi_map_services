import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uwifi_map_services/providers/popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/inputs/custom_checkbox.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/wigdets/gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondStep extends StatelessWidget {
  const SecondStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PopupController>(context);

    final List<Widget> serviceCheckboxes = [
      CustomCheckbox(
        value: controller.internetCheckbox,
        onChanged: controller.setInternetCheckbox,
        text: 'Internet',
      ),
      const SizedBox(width: 10),
      CustomCheckbox(
        value: controller.voiceCheckbox,
        onChanged: controller.setVoiceCheckbox,
        text: 'Voice',
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Call Now!',
          style: GoogleFonts.workSans(
            fontSize: 18,
            height: 1.5,
            color: const Color(0xff436aa5),
            fontWeight: FontWeight.w600,
          ),
        ),
        GradientButtonWidget(
          function: () => launchUrl(Uri.parse(("tel:5123604273"))),
          text: '512 360 4273',
        ),
        const SizedBox(height: 10),
        Text(
          'Or enter your contact information: ',
          style: GoogleFonts.workSans(
            fontSize: 13,
            height: 1.5,
            color: const Color(0xffD20030),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          maxHeight: 45,
                        ),
                      ),
                    ),

                    const SizedBox(width: 5),

                    //last name
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          maxHeight: 45,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                //phone
                TextFormField(
                  controller: controller.phoneController,
                  onChanged: (value) => controller.phone = value,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    final RegExp regex =
                        RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$");
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (!regex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Color(0xff324057)),
                  decoration: CustomInputs().formInputDecoration(
                    label: 'Phone Number',
                    icon: Icons.local_phone_outlined,
                    maxHeight: 45,
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
                    maxHeight: 45,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Please select the services you\'re interested in:',
            textAlign: TextAlign.center,
            style: GoogleFonts.workSans(
              fontSize: 13,
              height: 1.5,
              color: const Color(0xffD20030),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: serviceCheckboxes,
        ),
        const SizedBox(height: 10),
        CustomOutlinedButton(
          onPressed: () async {
            final isValid = controller.validateForm();
            if (isValid) {
              await controller.createCoverageLead();
              controller.changeStep();
            }
          },
          text: 'Submit',
          bgColor: const Color(0xFFD20030),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
