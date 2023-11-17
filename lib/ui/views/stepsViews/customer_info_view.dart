// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/customer_location_display.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/customer_personal_details_form.dart';

import '../../../providers/customer_info_controller.dart';
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
  final ScrollController _watchchecks = ScrollController();
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

      _watchchecks.addListener(() {
        double maxScroll = _watchchecks.position.maxScrollExtent;

        if (_watchchecks.offset >= (maxScroll - 85) ||
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
    final customerInfo = Provider.of<CustomerInfoProvider>(context);
    final bool isRep = customerInfo.customerInfo.customerRep != '';
    return Scaffold(
      backgroundColor: const Color(0xFFDFEDFF),
      body: (MediaQuery.of(context).size.width > 1130)
          ? Scrollbar(
              controller: _watchchecks,
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _watchchecks,
                child: _WebView(
                    street: widget.street,
                    city: widget.city,
                    state: widget.state,
                    zipcode: widget.zipcode),
              ))
          :

          ///CLASS JAIL HERE
          SingleChildScrollView(
              controller: _watchchecks,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    isRep ? 'Customer Information' : 'Your Information',
                    style: subtitleStyle(context),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        key: itemKey,
                        child: const CustomerPersonalDetailsForm()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      key: itemKey2,
                      child: CustomerLocationDisplay(
                        street: widget.street,
                        city: widget.city,
                        state: widget.state,
                        zcode: widget.zipcode,
                      ),
                    ),
                  ),
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
                      if (isRep)
                        Flexible(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(
                                    side: BorderSide(
                                        color: Color(0xFF2E5899), width: 2),
                                  ),
                                  primary: const Color(0xFFDFEDFF),
                                  minimumSize: const Size.fromHeight(50)),
                              child: const FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  Icons.location_history_outlined,
                                  color: Color(0xFFD20030),
                                  size: 30,
                                ),
                              ),
                              onPressed: () => scrollToItem()),
                        ),
                      SizedBox(
                        width: 70,
                        child: Visibility(
                            visible: !stepsController.promoCheckFlag,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/bouncy_down.gif'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'Scroll Down',
                                    style: GoogleFonts.workSans(
                                        fontSize: 13,
                                        color: const Color(0xFF2e5899),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -1.5),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      if (isRep)
                        Flexible(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(
                                    side: BorderSide(
                                        color: Color(0xFF2E5899), width: 2),
                                  ),
                                  primary: const Color(0xFFDFEDFF),
                                  minimumSize: const Size.fromHeight(50)),
                              child: Image.asset(
                                'images/pointer.png',
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                              onPressed: () => scrollToItem2()),
                        ),
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
  final String street;
  final String city;
  final String state;
  final String zipcode;
  const _WebView(
      {Key? key,
      required this.street,
      required this.city,
      required this.state,
      required this.zipcode})
      : super(key: key);

  @override
  State<_WebView> createState() => _WebViewState();
}

class _WebViewState extends State<_WebView> {
  @override
  Widget build(BuildContext context) {
    final customerInfo = Provider.of<CustomerInfoProvider>(context);
    final bool isRep = customerInfo.customerInfo.customerRep != '';
    return SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
          child: Column(
            children: [
              Center(
                child: Text(
                  isRep ? 'Customer Information' : 'Your Information',
                  style: subtitleStyle(context),
                ),
              ),
              const SizedBox(height: 25),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  const FractionallySizedBox(
                      widthFactor: 0.55, child: CustomerPersonalDetailsForm()),
                  const SizedBox(width: 30),
                  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: CustomerLocationDisplay(
                      street: widget.street,
                      city: widget.city,
                      state: widget.state,
                      zcode: widget.zipcode,
                    ),
                  ),
                  const SizedBox(
                    width: 250,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
