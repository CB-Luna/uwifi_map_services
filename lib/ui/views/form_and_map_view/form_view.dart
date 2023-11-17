// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/home_page.dart';
import 'package:uwifi_map_services/providers/search_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';
import 'package:uwifi_map_services/ui/views/widgets/custom_list_tile.dart';
import '../../../providers/portability_form_provider.dart';
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
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;

    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    // ignore: undefined_prefixed_name

    final tracking = Provider.of<TrackingProvider>(context);

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
                              //Street
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
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
                                          color: Color(0xff324057)),
                                      decoration:
                                          CustomInputs().formInputDecoration(
                                        label: 'Address Search',
                                        icon: Icons.location_pin,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  //Zipcode
                                  Flexible(
                                    flex: 1,
                                    child: TextFormField(
                                      key: const ObjectKey('zipcode'),
                                      controller: controller.zipcodeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a zipcode';
                                        }
                                        return null;
                                      },
                                      style: const TextStyle(
                                          color: Color(0xff324057)),
                                      decoration:
                                          CustomInputs().formInputDecoration(
                                        label: 'Zipcode',
                                        icon: Icons.house,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              // Row(
                              //   children: [
                              //     //City
                              //     Flexible(
                              //       child: TextFormField(
                              //         key: const ObjectKey('city'),
                              //         readOnly: true,
                              //         enabled: false,
                              //         controller: controller.cityController,
                              //         style: const TextStyle(
                              //             color: Color(0xff324057)),
                              //         decoration:
                              //             CustomInputs().formInputDecoration(
                              //           label: 'City',
                              //           icon: Icons.business,
                              //         ),
                              //       ),
                              //     ),

                              //     const SizedBox(
                              //       width: 10,
                              //     ),

                              //     //State
                              //     Flexible(
                              //       child: TextFormField(
                              //         key: const ObjectKey('state'),
                              //         readOnly: true,
                              //         enabled: false,
                              //         controller: controller.stateController,
                              //         style: const TextStyle(
                              //             color: Color(0xff324057)),
                              //         decoration:
                              //             CustomInputs().formInputDecoration(
                              //           label: 'State',
                              //           icon: Icons.assistant_photo_outlined,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

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

                                await widget.showPopup(controller, context);
                                portabilityFormProvider.portNumberStreet =
                                    controller.street;
                                portabilityFormProvider.portCity =
                                    controller.city;
                                portabilityFormProvider.portState =
                                    controller.state;
                                portabilityFormProvider.portZipcode =
                                    controller.zipcode;
                                var customer = controller.fillCustomerInfo();
                                tracking.setOrigin = controller.origin;
                                if (!(controller.customerRep != '')) {
                                  tracking.recordTrack(customerInfo: customer);
                                }
                              }
                              // var leadInfo = CustomerInfo(
                              //   street: controller.street,
                              //   city: controller.city,
                              //   state: controller.state,
                              //   zipcode: controller.zipcode,
                              //   coverageType: controller.coverageType,
                              //   locationGroup: controller.locationgroup,
                              //   customerRep: '',
                              //   location: location!.position, origin: '',
                              // );

                              // if (!(controller.customerRep != '')) {
                              //   var customer = controller.fillCustomerInfo();
                              //   tracking.setOrigin = controller.origin;
                              //   tracking.recordTrack(customerInfo: customer);
                              // }
                            }
                            // ignore: use_build_context_synchronously
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          text: 'Check for services',
                          bgColor: const Color(0xFF37BE88),
                        );
                      }),

                      mobile
                          ? const SizedBox(height: 5)
                          : const SizedBox(height: 20),
                      // Column(
                      //   children: [
                      // Text("Questions?",
                      //     style: GoogleFonts.workSans(
                      //       color: const Color(0xFF8aa7d2),
                      //     )),
                      // const SizedBox(height: 5),
                      // GradientButtonWidget(
                      //     function: () => showGeneralDialog(
                      //         context: context,
                      //         barrierColor:
                      //             const Color(0x00022963).withOpacity(0.40),
                      //         barrierDismissible: true,
                      //         barrierLabel: "",
                      //         transitionDuration:
                      //             const Duration(milliseconds: 500),
                      //         transitionBuilder: (context, animation,
                      //             secondaryAnimation, child) {
                      //           var curve = Curves.decelerate
                      //               .transform(animation.value);
                      //           return Transform.scale(
                      //               scale: curve, child: PopupFormZip());
                      //         },
                      //         pageBuilder: (context, animation,
                      //                 secondaryAnimation) =>
                      //             const SizedBox()),
                      //     text: "Call to your local office",
                      //     fontSize: 14)
                      //   ],
                      // ),

                      //
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
                                color: Colors.blue.shade100,
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
                                    color: const Color(0xff001E4D),
                                    fontWeight: FontWeight.w200),
                              )),
                            ),
                            CustomOutlinedButton(
                              onPressed: () {
                                controller.clickOKWarning();
                              },
                              text: 'OK',
                              bgColor: const Color(0xFFD20030),
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
