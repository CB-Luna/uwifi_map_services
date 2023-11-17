import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:uwifi_map_services/classes/home_page.dart';

import 'package:uwifi_map_services/providers/search_controller.dart';

class MapView extends StatelessWidget with HomePage {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = Provider.of<SearchLocalController>(context);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'map',
      (int viewId) => searchController.helper.elem,
    );

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              const HtmlElementView(viewType: 'map'),
              Visibility(
                visible: searchController.isLoading,
                child: PointerInterceptor(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SpinKitCircle(
                          size: 200,
                          itemBuilder: (context, index) {
                            final colors = [
                              const Color(0xFFD20030),
                              Colors.white,
                              const Color(0xffB6D9F9)
                            ];
                            final color = colors[index % colors.length];
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: color, shape: BoxShape.circle),
                            );
                          },
                        ),
                        SizedBox(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontFamily: 'Work Sans',
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('Loading'),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // searchController.locationConfirmed
        //     ? Container(
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           boxShadow: [
        //             BoxShadow(
        //               blurRadius: 20,
        //               spreadRadius: -10,
        //               color: const Color(0xFF2e5899).withOpacity(0.35),
        //               offset: const Offset(0, -25),
        //             ),
        //             BoxShadow(
        //               blurRadius: 30,
        //               spreadRadius: -15,
        //               color: const Color(0xFF2e5899).withOpacity(0.15),
        //             )
        //           ],
        //         ),
        //         padding: const EdgeInsets.all(10),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: [
        //             const CustomStep(icon: Icons.search, texts: [
        //               "Step 2: Check for services",
        //             ]),
        //             PointerInterceptor(
        //                 //This widget is necessary to prevent the HtmlElementView
        //                 //from capturing all mouse events
        //                 child: CustomOutlinedButton(
        //               onPressed: () async {
        //                 // await showPopup(searchController, context);
        //                 // portabilityFormProvider.portNumberStreet =
        //                 //     searchController.street;
        //                 // portabilityFormProvider.portCity =
        //                 //     searchController.city;
        //                 // portabilityFormProvider.portState =
        //                 //     searchController.state;
        //                 // portabilityFormProvider.portZipcode =
        //                 //     searchController.zipcode;

        //                 // if (!(searchController.customerRep != '')) {
        //                 //   var customer = searchController.fillCustomerInfo();
        //                 //   tracking.setOrigin = searchController.origin;
        //                 //   tracking.recordTrack(customerInfo: customer);
        //                 // }
        //               },
        //               text: 'Check for Service',
        //               bgColor: const Color(0xFF37BE88),
        //             )),
        //           ],
        //         ),
        //       )
        //     : Container(),
      ],
    );
  }
}
