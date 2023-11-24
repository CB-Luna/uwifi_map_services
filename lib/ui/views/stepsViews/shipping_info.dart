import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/steps_controller.dart';
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
  final controller = Provider.of<CustomerInfoProvider>(context);
    return Column(
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
                      'Shipping Details',
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          autocorrect: false,
                                          obscureText: false,
                                          keyboardType: TextInputType.name,
                                          decoration: CustomInputs()
                                              .formInputDecoration(
                                                  label: 'First Name',
                                                  icon: Icons.person_outlined),

                                          
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
                                            controller.setLastNameShipping(value);
                                            
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

                                          
                                          style: const TextStyle(
                                            color: colorPrimaryDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                
                            TextFormField(
                              /// VARIABLE STORAGE
                              controller: controller.parsedAddress,
                              onChanged: (value) =>
                                  controller.setAddressShipping(value),

                              ///VALIDATION TRIGGER
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              decoration: CustomInputs().formInputDecoration(
                                  label: 'Address', icon: Icons.house_outlined),
                              style: const TextStyle(
                                color: colorPrimaryDark,
                              ),
                            ),
                            TextFormField(
                              /// VARIABLE STORAGE
                              controller: controller.parsedPhone,
                              onChanged: (value) => controller.setphoneShipping(value),

                              ///VALIDATION TRIGGER
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              decoration: CustomInputs().formInputDecoration(
                                  label: 'Phone Number',
                                  icon: Icons.phone_outlined),

                              
                              
                              style: const TextStyle(
                                color: colorPrimaryDark,
                              ),
                            ),
                            
                          ]),
                    )),
              ),
      ],
    );
  }
}