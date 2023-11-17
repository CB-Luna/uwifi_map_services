import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';
import 'package:uwifi_map_services/providers/search_controller_portability_r.dart';
import 'package:uwifi_map_services/ui/views/referral/custom_inputs_r.dart';

import '../../../providers/referal_providers/portability_form_provider_r.dart';
import '../../../providers/referal_providers/screen_controller.dart';
import '../../buttons/custom_outlined_button.dart';
import '../portability_view/popups/popup_not_found.dart';
import '../widgets/custom_list_tile_portability_F.dart';

class FormViewR extends StatelessWidget {
  const FormViewR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final zipExp = RegExp(r'(^\d{5}$)|(^\d{9}$)|(^\d{5}-\d{4}$)');
    final phoneFormatter = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    final size = MediaQuery.of(context).size;

    final bool mobile = size.width < 800 ? true : false;

    final screenController = Provider.of<ScreenController>(context);

    final portabilityFormProvider =
        Provider.of<PortabilityFormProviderR>(context, listen: false);

    final searchControllerPortability =
        Provider.of<SearchControllerPortabilityR>(context);

    final places = searchControllerPortability.places ?? [];
    if (places.isNotEmpty) {
      searchControllerPortability.hasSuggestions = true;
    } else {
      searchControllerPortability.hasSuggestions = false;
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
            key: portabilityFormProvider.formKey,
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    //ReferalId

                    FractionallySizedBox(
                      widthFactor: mobile ? 1 : 0.26,
                      child: Padding(
                        padding: EdgeInsets.only(top: mobile ? 0 : 20.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please, enter a Customer ID';
                            // }

                            return null;
                          },
                          controller:
                              searchControllerPortability.customerIdController,
                          onChanged: (value) =>
                              portabilityFormProvider.customerId = value,
                          style: const TextStyle(color: Color(0xff324057)),
                          decoration: CustomInputs.formInputDecoration(
                            label: 'Customer ID',
                            icon: Icons.perm_identity_rounded,

                            //maxWidth: 360
                          ),
                        ),
                      ),
                    ),

                    if (!mobile) const SizedBox(width: 20),
                    // Email
                    FractionallySizedBox(
                      widthFactor: mobile ? 1 : 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          controller:
                              searchControllerPortability.emailController,
                          onChanged: (value) =>
                              portabilityFormProvider.portEmail = value,
                          style: const TextStyle(color: Color(0xff324057)),
                          decoration: CustomInputs.formInputDecoration(
                            label: 'Email',
                            icon: Icons.email_outlined,
                            //maxWidth: 360
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    //First Name
                    Flexible(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        onChanged: (value) =>
                            portabilityFormProvider.portFirstName = value,
                        // validator: (value) {
                        //   return nameCharacters.hasMatch(value ?? '')
                        //       ? null
                        //       : 'Enter a valid name';
                        // },
                        // controller: searchControllerPortability.nameController,
                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'First Name',
                          icon: Icons.person_outline_sharp,
                          //maxWidth: 360
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    //Last Name
                    Flexible(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        onChanged: (value) =>
                            portabilityFormProvider.portLastName = value,
                        // validator: (value) {
                        //   return nameCharacters.hasMatch(value ?? '')
                        //       ? null
                        //       : 'Enter a valid name';
                        // },
                        // controller:
                        //     searchControllerPortability.lastNameController,
                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'Last Name',
                          icon: Icons.person_outline_sharp,
                          //maxWidth: 360
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    //Street Address
                    FractionallySizedBox(
                      widthFactor: mobile ? 1 : 0.48,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          searchControllerPortability.street = value;
                          portabilityFormProvider.portNumberStreet = value;
                          searchControllerPortability
                              .onAddressChangedFormView(value);
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter an address';
                        //   }
                        //   return null;
                        // },
                        controller:
                            searchControllerPortability.addressController,

                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'Service Address', icon: Icons.location_pin,
                          //maxWidth: 360
                        ),
                      ),
                    ),

                    if (!mobile) const SizedBox(width: 20),

                    //Phone Number
                    FractionallySizedBox(
                      widthFactor: mobile ? 1 : 0.48,
                      child: Padding(
                        padding: EdgeInsets.only(top: mobile ? 20 : 0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(12),
                            phoneFormatter
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return null;
                            } else {
                              return (value.length == 12)
                                  ? null
                                  : 'Please, enter a valid phone number';
                            }
                          },
                          controller:
                              searchControllerPortability.phoneController,
                          onChanged: (value) =>
                              portabilityFormProvider.phoneNumber = value,
                          style: const TextStyle(color: Color(0xff324057)),
                          decoration: CustomInputs.formInputDecoration(
                            label: 'Phone Number',
                            icon: Icons.phone_rounded,

                            //maxWidth: 360
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    //zipcode
                    Flexible(
                      child: TextFormField(
                        onChanged: (value) =>
                            portabilityFormProvider.portZipcode = value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return zipExp.hasMatch(value ?? '')
                              ? null
                              : 'Enter a valid zip code';
                        },
                        controller: searchControllerPortability.zipController,
                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'Zip Code',
                          icon: Icons.house,
                          //maxWidth: 130
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    //city
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a city';
                        //   }
                        //   return null;
                        // },
                        controller: searchControllerPortability.cityController,
                        onChanged: (value) =>
                            portabilityFormProvider.portCity = value,
                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'City',
                          icon: Icons.business,
                          //maxWidth: 130
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    //state
                    Flexible(
                      child: TextFormField(
                        enabled: false,
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter a state';
                        //   }
                        //   return null;
                        // },
                        controller: searchControllerPortability.stateController,
                        style: const TextStyle(color: Color(0xff324057)),
                        decoration: CustomInputs.formInputDecoration(
                          label: 'State',
                          icon: Icons.assistant_photo_outlined,
                          //maxWidth: 130
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: places.length > 1 ? true : false,
                  child: SizedBox(
                    height: mobile ? 120 : 150,
                    child: Material(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: places.length,
                        itemBuilder: (_, index) {
                          final place = places[index];
                          return CustomListTilePortabilityF(
                            controller: searchControllerPortability,
                            place: place,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomOutlinedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: 'Close'),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomOutlinedButton(
                        onPressed: () async {
                          final isValid =
                              portabilityFormProvider.validateForm();
                          if (isValid) {
                            portabilityFormProvider.portNumberStreet =
                                searchControllerPortability
                                    .addressController.text;
                            portabilityFormProvider.portZipcode =
                                searchControllerPortability.zipController.text;
                            portabilityFormProvider.portCity =
                                searchControllerPortability.cityController.text;
                            portabilityFormProvider.portState =
                                searchControllerPortability
                                    .stateController.text;

                            portabilityFormProvider.engageUsed = true;

                            if (await portabilityFormProvider
                                .getPortabilityAccess()) {
                              Navigator.pop(context);
                              screenController.validateScreen(context);
                            } else {
                              popUpNotFound(context);
                            }
                          }
                        },
                        text: 'Continue'),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
//Un cambio