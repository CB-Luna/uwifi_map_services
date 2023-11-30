import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({Key? key}) : super(key: key);

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CustomerShippingInfo>(context);
    final validCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final phoneCharacters = RegExp(r'^[0-9\-() ]+$');
    final addressChar = RegExp(r'^[a-zA-Z0-9\-()]+$');

    return SizedBox(
      width: 1400,
      child: Column(
        children: [
          Container(
            width: 1400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              color: colorPrimary,
            ),
            child: const Padding(
              padding: EdgeInsets.all(25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Step 3: Shipping Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Form(
              key: controller.formKey,
                child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedFName,
                            onChanged: (value) {
                              controller.setNameShipping(value);
                            },
    
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            autocorrect: false,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'First Name',
                                icon: Icons.person_outlined,
                                maxHeight: 60),
    
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              return validCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter your name';
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedLName,
                            onChanged: (value) {
                              controller.setLastNameShipping(value);
                            },
    
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            autocorrect: false,
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Last Name',
                                icon: Icons.person_outlined,
                                maxHeight: 60),
    
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              return validCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter your name';
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedPhone,
                            onChanged: (value) =>
                                controller.setphoneShipping(value),
    
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Phone Number',
                                icon: Icons.phone_outlined,
                                maxHeight: 60),
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedAddress,
                            onChanged: (value) => controller.setAddress1(value),
    
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Address Line 1',
                                icon: Icons.house_outlined,
                                maxHeight: 60),
                            style: const TextStyle(
                              color: colorPrimaryDark,
                            ),
                            validator: (value) {
                              return addressChar.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter a valid address';
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedAddress,
                            onChanged: (value) => controller.setAddress2(value),
    
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
                            validator: (value) {
                              return addressChar.hasMatch(value ?? '')
                                  ? null
                                  : 'Please enter a valid address';
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedEmail,
                            onChanged: (value) {
                              controller.setZipcode(value);
                              // portabilityFormProvider.portEmail = value;
                            },
    
                            ///VALIDATION TRIGGER
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'Zipcode',
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            /// VARIABLE STORAGE
                            controller: controller.parsedAddress,
                            onChanged: (value) => controller.setCity(value),
    
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'City',
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
                            controller: controller.parsedAddress,
                            onChanged: (value) => controller.setState(value),
    
                            ///VALIDATION TRIGGER
                            // initialValue: dir,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            decoration: CustomInputs().formInputDecoration(
                                label: 'State',
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
