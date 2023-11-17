import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/search_controller_portability.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/custom_list_tile_portability.dart';

class PopNewFormAddressPortability extends StatelessWidget {
  const PopNewFormAddressPortability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final searchControllerPortability = Provider.of<SearchControllerPortability>(context);
    final places = searchControllerPortability.places ?? [];
      if (places.isNotEmpty) {
        searchControllerPortability.hasSuggestions = true;
      } else {
        searchControllerPortability.hasSuggestions = false;
      }
    return SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            width: 650,
            height: 550,
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: mobile ? 5 : 40),
            color: Colors.grey.shade300.withOpacity(0.5),
            child: Form(
                key: portabilityFormProvider.newFormAddressKey,
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Portability Data Validation',
                            style: GoogleFonts.poppins(
                              fontSize: mobile ? 15 : 30,
                              height: 1.2,
                              color: const Color(0xff2E5899),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Please fill out the form with your address info based on your current telephone bill',
                            style: GoogleFonts.poppins(
                              fontSize: mobile ? 13 : 25,
                              height: 1.5,
                              color: const Color(0xff001E4D),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
      
                          //Number and street
              
                          Flexible(
                            child: TextFormField(
                              // key: const ObjectKey('street'),
                              autofocus: true,
                              controller: searchControllerPortability.streetPortController,
                              onChanged: (value) {
                                searchControllerPortability.streetPort = value;
                                // portabilityFormProvider.portNumberStreet = searchControllerPortability.streetPort;
                                searchControllerPortability.onAddressChanged(value);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number and street';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Color(0xff324057)),
                              decoration: CustomInputs.formInputDecoration(
                                  label: 'Number and street', icon: Icons.location_pin,
                                  //maxWidth: 360
                                  ),
                            ),
                          ),
              
                          //zipcode
                          Flexible(
                            child: TextFormField(
                              // key: const ObjectKey('zipcode'),
                              controller: searchControllerPortability.zipcodePortController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a zipcode';
                                }
                                return null;
                              },
                              style: const TextStyle(color: Color(0xff324057)),
                              decoration: CustomInputs.formInputDecoration(
                                  label: 'Zipcode',
                                  icon: Icons.house,
                                  //maxWidth: 130
                                  ),
                            ),
                          ),
              
                          //city
                          Flexible(
                            child: TextFormField(
                              // key: const ObjectKey('city'),
                              readOnly: true,
                              enabled: false,
                              controller: searchControllerPortability.cityPortController,
                              style: const TextStyle(color: Color(0xff324057)),
                              decoration: CustomInputs.formInputDecoration(
                                  label: 'City',
                                  icon: Icons.business,
                                  //maxWidth: 130
                                  ),
                            ),
                          ),
              
                          //state
                          Flexible(
                            child: TextFormField(
                              // key: const ObjectKey('state'),
                              readOnly: true,
                              enabled: false,
                              controller: searchControllerPortability.statePortController,
                              style: const TextStyle(color: Color(0xff324057)),
                              decoration: CustomInputs.formInputDecoration(
                                  label: 'State',
                                  icon: Icons.assistant_photo_outlined,
                                  //maxWidth: 130
                                  ),
                            ),
                          ),
              
                          // Se usa material para que se dibuje encima del
                          // contenedor padre (con BoxDecoration)
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
                                    return CustomListTilePortability(
                                      place: place,
                                      controller: searchControllerPortability,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          CustomOutlinedButton(
                          onPressed: () {
                            final isValid = portabilityFormProvider.validateNewFormAddress();
                              if (isValid) {
                                portabilityFormProvider.portNumberStreet = searchControllerPortability.streetPort;
                                portabilityFormProvider.portZipcode = searchControllerPortability.zipcodePort;
                                portabilityFormProvider.portCity = searchControllerPortability.cityPort;
                                portabilityFormProvider.portState = searchControllerPortability.statePort;
                                selectorSummaryController.changeView(6);
                              }
                          },
                          text: 'Accept',
                          bgColor: const Color(0xFFD20030),
                        ),
                        ],),
                ),
          ),
        );
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}
//Un cambio