import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_provider.dart';
import 'package:uwifi_map_services/providers/steps_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/custom_drop_down.dart';
import 'package:uwifi_map_services/ui/views/widgets/custom_list_tile.dart';

class Step3ShippingDetailsForm extends StatefulWidget {
  const Step3ShippingDetailsForm({Key? key}) : super(key: key);

  @override
  State<Step3ShippingDetailsForm> createState() => _Step3ShippingDetailsFormState();
}

class _Step3ShippingDetailsFormState extends State<Step3ShippingDetailsForm> {
  @override
  Widget build(BuildContext context) {
    final customerPDSDController = Provider.of<CustomerPDSDProvider>(context);
    final stepsController = Provider.of<StepsController>(context);
    final zipcodeCharacters = RegExp(r'^[0-9\-() ]+$');
    var zipcodeFormat = MaskTextInputFormatter(
      mask: '######',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;

    final places = customerPDSDController.places ?? [];
    if (places.isNotEmpty) {
      customerPDSDController.hasSuggestions = true;
    } else {
      customerPDSDController.hasSuggestions = false;
    }

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
                        Icons.local_shipping_outlined,
                        color: colorInversePrimary,
                        size: isMobile ? 25 : 40,
                      ),
                    ),
                    Text(
                      'Shipping Details',
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
          key: stepsController.formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextFormField(
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedAddress1SD,
                          onChanged: (value) {
                            customerPDSDController.onAddressChanged(value);
                          },
                
                          ///VALIDATION TRIGGER
                          // initialValue: dir,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: CustomInputs().formInputDecoration(
                              label: 'Address Line 1*',
                              icon: Icons.house_outlined,
                              maxHeight: 55),
                          style: const TextStyle(
                            color: colorBgWhite,
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
                      Flexible(
                        child: TextFormField(
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedAddress2SD,
                
                          ///VALIDATION TRIGGER
                          // initialValue: dir,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: CustomInputs().formInputDecoration(
                              label: 'Address Line 2',
                              icon: Icons.house_outlined,
                              maxHeight: 55),
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),                      
                    ],
                  ),
                  isMobile ? Container() : const SizedBox(height: 5),
                
                  // Se usa material para que se dibuje encima del
                  // contenedor padre (con BoxDecoration)
                  Visibility(
                    visible: places.length > 1 ? true : false,
                    child: SizedBox(
                      height: isMobile ? 120 : 150,
                      child: Material(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: places.length,
                          itemBuilder: (_, index) {
                            final place = places[index];
                            return CustomListTile(
                              place: place,
                            );
                          },
                        ),
                      ),
                    ),
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
                          readOnly: true,
                          enabled: false,
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedCitySD,
                
                          ///VALIDATION TRIGGER
                          // initialValue: dir,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          decoration: CustomInputs().formInputDecoration(
                              label: 'City*',
                              icon: Icons.house_outlined,
                              maxHeight: 55,
                              isAvailable: false),
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: TextFormField(
                          /// VARIABLE STORAGE
                          controller: customerPDSDController.parsedZipcodeSD,
                
                          ///VALIDATION TRIGGER
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          decoration: CustomInputs().formInputDecoration(
                              label: 'Zipcode*',
                              icon: Icons.other_houses_outlined,
                              maxHeight: 55),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            zipcodeFormat
                          ],
                          validator: (value) {
                            return (zipcodeCharacters
                                        .hasMatch(value ?? '') &&
                                    value?.length == 5)
                                ? null
                                : 'Please enter a valid zipcode';
                          },
                          style: const TextStyle(
                            color: colorBgWhite,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: CustomDropDown(
                          validator: (value) {
                            return (value == "" || value == null)
                              ? 'Please select a state.'
                              : null;
                          },
                          maxHeight: 55,
                          icon: Icons.house_outlined,
                          label: 'State*',
                          width: double.infinity,
                          list: customerPDSDController.stateCodes.values.toList(),
                          dropdownValue: customerPDSDController.parsedStateSD.text == "" ? null : 
                            customerPDSDController.parsedStateSD.text,
                          onChanged: (newState) {
                            if (newState == null) return;
                            customerPDSDController.selectStateUpdateSD(newState);
                          },
                        ),
                      ),
                    ],
                  ),
                ])),
      ],
    );
  }
}
