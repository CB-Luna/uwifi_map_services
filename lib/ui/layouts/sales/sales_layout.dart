import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';

import 'package:uwifi_map_services/providers/tracking_provider.dart' as track;
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/customer_info_checks.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart.dart';

import '../../../data/constants.dart';
import '../../../providers/remote/boxes_behavior_controller.dart';
import '../../../providers/steps_controller.dart';

import 'widgets/navigation_bar_mobile.dart';
import 'widgets/top_bar.dart';

class SalesLayout extends StatelessWidget {

  SalesLayout({
    Key? key,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // String? custAddress = "${customerInfo.street}, ${customerInfo.city} ${customerInfo.state} ${customerInfo.zipcode}";


    return MultiProvider(
        providers: [
          ChangeNotifierProvider<StepsController>(
            create: (_) => StepsController(),
          ),
          ChangeNotifierProvider<BoxesBehavior>(
            create: (_) =>
                BoxesBehavior(mobile(context)),
          ),
        ],
        builder: (context, child) {
          final customerController = Provider.of<CustomerInfoProvider>(context);
          final stepsController = Provider.of<StepsController>(context);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: mobile(context)
                ? NavigationMobile(customerController: customerController)
                : null,
            key: _scaffoldKey,
            backgroundColor: colorBgB,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopBar(),
                Expanded(
                  child: Row(
                    //Con este parámatro se ajusta la posición del Shopping Cart
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    //Despliegue de contenido de página en Stepper
                    Flexible(
                        child: stepsController
                          .changeStep(stepsController.currentStep)),

                    //Despliegue de Shopping Cart
                    if (!mobile(context)) Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CartWidget(),
                        ),
                        //CheckBoxes
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: cartWidth,
                            height: MediaQuery.of(context).size.height * 0.35,
                            decoration: BoxDecoration(
                              color: colorInversePrimary,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: -5,
                                  color: colorBgB,
                                  offset: Offset(0, 15),
                                )
                              ],
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child:SingleChildScrollView(
                              controller: ScrollController(),
                              child: const PromoCheckbox()),
                          ),
                        ),
                      ],
                    )
                  ]),
                )
              ],
            ),
          );
        });
  }
}
