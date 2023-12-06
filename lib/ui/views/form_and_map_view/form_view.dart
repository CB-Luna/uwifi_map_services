// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps/google_maps.dart' as LatLng;
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/home_page.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_shipping_controller.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/widgets/custom_list_tile.dart';
import '../../../providers/tracking_provider.dart';

class FormView extends StatefulWidget with HomePage {
  const FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width >= 1130 ? true : false;
    // ignore: undefined_prefixed_name

    final tracking = Provider.of<TrackingProvider>(context);
    final customerShippingInfoProvider = Provider.of<CustomerShippingInfo>(context);

    return Builder(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<SearchLocalController>(
                        builder: (_, controller, __) {
                          final places = controller.places ?? [];
                          if (places.isNotEmpty) {
                            controller.hasSuggestions = true;
                          } else {
                            controller.hasSuggestions = false;
                          }

                          WidgetsBinding.instance
                              .addPostFrameCallback((_) async {
                            if (controller.addressPrefilled) {
                              controller.addressPrefilled = false;
                              await controller.initForm();

                              controller.fillCustomerInfo();
                              tracking.setOrigin = controller.origin;
                              // ignore: use_build_context_synchronously
                              await widget.showPopup(controller, context);
                            }
                          });

                          return Column(
                            children: [
                              Container(
                                width: mobile ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                decoration: ShapeDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment(-0.02, 1.00),
                                    end: Alignment(0.02, -1),
                                    colors: [colorPrimaryDark, colorPrimaryLight],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      color: colorPrimary,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: colorsTheme(context).secondary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(Icons.my_location_rounded,
                                              size: mobile ? 32 : 16, color: colorsTheme(context).inversePrimary),
                                        ),
                                        Flexible(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Step 1: Find your Address',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: colorInversePrimary,
                                                  fontSize: mobile ? 32 : 20,
                                                  fontFamily: 'Quicksand',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                'Enter your address location',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: colorInversePrimary,
                                                  fontSize: mobile ? 20 : 14,
                                                  fontFamily: 'Quicksand',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Column(
                                      children: [
                                        //Street
                                        TextFormField(
                                          key: const ObjectKey('street'),
                                          autofocus: true,
                                          controller: controller.streetController,
                                          onChanged: (value) {
                                            controller.street = value;
                                            controller.onAddressChanged(value);
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a valid address';
                                            }
                                            return null;
                                          },
                                          style: const TextStyle(
                                              color: colorPrimaryDark),
                                          decoration:
                                              CustomInputs().formInputDecoration(
                                            label: 'Address Search',
                                            icon: Icons.location_pin,
                                          ),
                                        ),
                                    
                                        const SizedBox(
                                          height: 20,
                                        ),
                                    
                                        //Zipcode
                                        TextFormField(
                                          key: const ObjectKey('zipcode'),
                                          controller: controller.zipcodeController,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a zipcode';
                                            }
                                            return null;
                                          },
                                          style: const TextStyle(
                                              color: colorPrimaryDark),
                                          decoration:
                                              CustomInputs().formInputDecoration(
                                            label: 'Zipcode',
                                            icon: Icons.house,
                                          ),
                                        ),
                                    
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        
                                        mobile ? Container() : const SizedBox(height: 10),
                                    
                                        // Se usa material para que se dibuje encima del
                                        // contenedor padre (con BoxDecoration)
                                        Material(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: places.length,
                                            itemBuilder: (_, index) {
                                              final place = places[index];
                                              return CustomListTile(
                                                place: place,
                                                controller: controller,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      mobile
                          ? const SizedBox(height: 15)
                          : const SizedBox(height: 20),

                      //Apply button
                      Builder(builder: (context) {
                        final controller =
                            context.watch<SearchLocalController>();
                        final location = controller.location;
                        return CustomOutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.fillAddressFields();
                              controller.confirmLocation();
                              controller.clearPlaces();

                              if (location != null ||
                                  controller.locationConfirmed) {
                                if (location == null) {
                                  //El usuario escribe algo en el input sin elegir un item de la lista
                                  await controller.getLocation();
                                } else {
                                  print('Location is: ${location.address}');
                                  print(location.position);
                                  controller.changeLocation(location.position);
                                }

                                if(!mounted) return;
                                await widget.showPopup(controller, context);
                                customerShippingInfoProvider.parsedAddress1PD.text =
                                    controller.street;
                                customerShippingInfoProvider.parsedCityPD.text =
                                    controller.city;
                                customerShippingInfoProvider.parsedStatePD.text =
                                    controller.state;
                                customerShippingInfoProvider.parsedZipcodePD.text =
                                    controller.zipcode;
                                customerShippingInfoProvider.locatizationPD = 
                                    controller.currentLocation;
                                customerShippingInfoProvider.parsedAddress1SD.text = 
                                    controller.street;
                                customerShippingInfoProvider.parsedZipcodeSD.text = 
                                    controller.zipcode;
                                customerShippingInfoProvider.parsedCitySD.text = 
                                    controller.city;
                                customerShippingInfoProvider.parsedStateSD.text = 
                                    controller.state;
                                customerShippingInfoProvider.locatizationSD = 
                                    controller.currentLocation;
                                tracking.setOrigin = controller.origin;
                              }
                            }
                            if(!mounted) return;
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          text: 'Check for services',
                          bgColor: colorsTheme(context).secondary,
                        );
                      }),

                      mobile
                          ? const SizedBox(height: 5)
                          : const SizedBox(height: 20),
                    ],
                  ),
                  Builder(builder: (context) {
                    final controller = context.watch<SearchLocalController>();
                    return Visibility(
                      visible: controller.isVisibleWarning,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorsTheme(context).background,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              width: 600,
                              height: 200,
                              padding: const EdgeInsets.all(3),
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Center(
                                  child: Text(
                                'Address not found \n Please verify the input data',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: colorsTheme(context).onPrimary,
                                    fontWeight: FontWeight.w200),
                              )),
                            ),
                            CustomOutlinedButton(
                              onPressed: () {
                                controller.clickOKWarning();
                              },
                              text: 'OK',
                              bgColor: colorsTheme(context).secondary,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
