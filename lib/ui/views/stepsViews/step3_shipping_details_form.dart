import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/providers/steps_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class Step3ShippingDetailsForm extends StatefulWidget {
  const Step3ShippingDetailsForm({Key? key}) : super(key: key);

  @override
  State<Step3ShippingDetailsForm> createState() => _Step3ShippingDetailsFormState();
}

class _Step3ShippingDetailsFormState extends State<Step3ShippingDetailsForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CustomerShippingInfo>(context);
    final stepController = Provider.of<StepsController>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final isMobile = MediaQuery.of(context).size.width > 1130 ? true : false;

    return Container(
      width: 1400,
      height: 250,
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
        children: [
          Container(
            width: 1400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              color: colorPrimary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.local_shipping_outlined,
                            color: colorInversePrimary,
                            size: 40,
                          ),
                        ),
                        isMobile ?
                        const Text(
                          'Step 3: Shipping Details',
                          style: TextStyle(
                            color: colorInversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                        :
                        const Text(
                          'Step 3:\nShipping Details',
                          style: TextStyle(
                            color: colorInversePrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Wrap(
                          children: [
                            const Icon(
                              Icons.person_outlined,
                              color: colorInversePrimary,
                              size: 20,
                            ),
                            Text(
                              "${controller.parsedFNamePD.text} ${controller.parsedLNamePD.text}",
                              style: GoogleFonts.workSans(
                                  fontSize: 16,
                                  color: colorInversePrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Same as Personal Details',
                              style: GoogleFonts.workSans(
                              fontSize: 12,
                              color: colorInversePrimary,
                              fontWeight: FontWeight.normal)),
                            Checkbox(
                              side: const BorderSide(
                                color: colorBgWhite,
                                width: 2.0
                              ),
                              value: controller.sameAsPD,
                              onChanged: (bool? value) {
                                controller.changeValuesShippingDetails();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Form(
              key: stepController.formKey,
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedAddress1SD,
      
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Address Line 1*',
                                icon: Icons.house_outlined,
                                maxHeight: 60),
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedAddress2SD,
      
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Address Line 2',
                                icon: Icons.house_outlined,
                                maxHeight: 60),
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedZipcodeSD,
      
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Zipcode*',
                                icon: Icons.other_houses_outlined,
                                maxHeight: 60),
      
                            validator: (value) {
                              return (phoneCharacters.hasMatch(value ?? '') &&
                                      value?.length == 5)
                                  ? null
                                  : 'Please enter a valid Zipcode';
                            },
                            style: const TextStyle(
                              color: colorPrimaryDark,
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
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedCitySD,
      
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'City*',
                                icon: Icons.house_outlined,
                                maxHeight: 60),
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              return validCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter a City';
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedStateSD,
      
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'State*',
                                icon: Icons.house_outlined,
                                maxHeight: 60),
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              return validCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter a State';
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
            )),
          ),
        ],
      ),
    );
  }
}
