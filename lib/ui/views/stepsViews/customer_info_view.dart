// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step1_personal_details_form.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step3_billing_information.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/step2_shipping_details_form.dart';

import '../../../providers/steps_controller.dart';

class CustomerInfoView extends StatefulWidget {
  final String street;
  final String city;
  final String state;
  final String zipcode;

  const CustomerInfoView(
      {Key? key,
      required this.street,
      required this.city,
      required this.state,
      required this.zipcode})
      : super(key: key);

  @override
  CustomerInfoViewState createState() => CustomerInfoViewState();
}

class CustomerInfoViewState extends State<CustomerInfoView> {
  final ScrollController _scrollController = ScrollController();
  final itemKey = GlobalKey();
  final itemKey2 = GlobalKey();

  Future scrollToItem() async {
    final context = itemKey.currentContext!;
    await Scrollable.ensureVisible(context,
        duration: const Duration(milliseconds: 500));
  }

  Future scrollToItem2() async {
    final context = itemKey2.currentContext!;
    await Scrollable.ensureVisible(context,
        duration: const Duration(milliseconds: 500));
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var stepsController =
          Provider.of<StepsController>(context, listen: false);
      (MediaQuery.of(context).size.width >= 1130)
          ? stepsController.promoCheck(true)
          : stepsController.promoCheck(false);

      _scrollController.addListener(() {
        double maxScroll = _scrollController.position.maxScrollExtent;

        if (_scrollController.offset >= (maxScroll - 85) ||
            MediaQuery.of(context).size.width >= 1130) {
          setState(() {
            stepsController.promoCheck(true);
          });
        } else {
          setState(() {
            stepsController.promoCheck(false);
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var stepsController = Provider.of<StepsController>(context, listen: false);
    // final customerInfo = Provider.of<CustomerInfoProvider>(context);
    return Scaffold(
      backgroundColor: colorBgB,
      body: (MediaQuery.of(context).size.width > 1130)
          ? const _WebView()
          :
          ///CLASS JAIL HERE
          SingleChildScrollView(
              controller: _scrollController,
              child: const Column(
                children: [
                  SizedBox(
                    height: 10
                  ),
                  Step1PersonalDetailsForm(),
                  SizedBox(
                    height: 10,
                  ),
                  Step2ShippingDetailsForm(),
                  SizedBox(
                    height: 10,
                  ),
                  Step3BillingInformationForm(),
                ],
              ),
            ),

      //?CLASS JAIL
      // : _portView(
      //     street: widget.street,
      //     city: widget.city,
      //     state: widget.state,
      //     zipcode: widget.zipcode),
      ///CLASS JAIL
      bottomNavigationBar: (MediaQuery.of(context).size.width > 1130)
          ? null
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      // if (isRep)
                      //   Flexible(
                      //     child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             shape: const CircleBorder(
                      //               side: BorderSide(
                      //                   color: colorPrimary, width: 2),
                      //             ),
                      //             primary: colorPrimary,
                      //             minimumSize: const Size.fromHeight(50)),
                      //         child: const FittedBox(
                      //           fit: BoxFit.contain,
                      //           child: Icon(
                      //             Icons.location_history_outlined,
                      //             color: colorPrimary,
                      //             size: 30,
                      //           ),
                      //         ),
                      //         onPressed: () => scrollToItem()),
                      //   ),
                      SizedBox(
                        width: 70,
                        child: Visibility(
                            visible: !stepsController.promoCheckFlag,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.expand_circle_down_outlined,
                                  color: colorSecondary,
                                  size: 40,),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'Scroll Down',
                                    style: GoogleFonts.workSans(
                                        fontSize: 13,
                                        color: colorSecondary,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -1.5),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      // if (isRep)
                      //   Flexible(
                      //     child: ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             shape: const CircleBorder(
                      //               side: BorderSide(
                      //                   color: colorSecondary, width: 2),
                      //             ),
                      //             primary: colorSecondary,
                      //             minimumSize: const Size.fromHeight(50)),
                      //         child: Image.asset(
                      //           'images/pointer.png',
                      //           height: 28,
                      //           fit: BoxFit.contain,
                      //         ),
                      //         onPressed: () => scrollToItem2()),
                      //   ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class _WebView extends StatefulWidget {
  const _WebView(
      {Key? key})
      : super(key: key);

  @override
  State<_WebView> createState() => _WebViewState();
}

class _WebViewState extends State<_WebView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: ScrollController(),
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
          child: const Column(
            children: [
              Center(),
              Step1PersonalDetailsForm(),
              SizedBox(height: 10),
              Step2ShippingDetailsForm(),
              SizedBox(height: 10),
              Step3BillingInformationForm(),
            ],
          ),
        ));
  }
}
