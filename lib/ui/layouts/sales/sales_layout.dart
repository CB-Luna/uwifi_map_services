import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_map_services/classes/customer_info.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';

import 'package:uwifi_map_services/providers/tracking_provider.dart' as track;
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart.dart';

import '../../../data/constants.dart';
import '../../../providers/remote/boxes_behavior_controller.dart';
import '../../../providers/steps_controller.dart';

import '../../views/stepsViews/widgets/promos_list_box.dart';
import 'widgets/navigation_bar_mobile.dart';
import 'widgets/top_bar.dart';

class SalesLayout extends StatelessWidget {
  final CustomerInfo customerInfo;

  SalesLayout({
    Key? key,
    required this.customerInfo,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String? custAddress = "${customerInfo.street}, ${customerInfo.zipcode}";

    final tracking = Provider.of<track.TrackingProvider>(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PlanController>(
            create: (_) => PlanController(
              customerInfo.coverageType,
              customerInfo.serviceType,
              customerInfo.locationGroup,
            ),
            lazy: false,
          ),
          ChangeNotifierProvider<StepsController>(
            create: (_) => StepsController(customerInfo),
          ),
          ChangeNotifierProvider<CustomerInfoProvider>(
            create: (_) => CustomerInfoProvider(
              tracking.origin,
              customerInfo: customerInfo,
            ),
          ),
          ChangeNotifierProvider<BoxesBehavior>(
            create: (_) =>
                BoxesBehavior(mobile(context), customerInfo.customerRep),
          ),
        ],
        builder: (context, child) {
          final customerController = Provider.of<CustomerInfoProvider>(context);
          final stepsController = Provider.of<StepsController>(context);

          bool isRep = customerController.customerInfo.customerRep != "";

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
                TopBar(custAddress: custAddress),
                Expanded(
                  child: Row(children: [
                    //Despliegue de Promos list
                    if (isRep)
                      if (stepsController.repCurrentStep == RepViews.plansView)
                        const PromosListBox(),

                    //Despliegue de planes
                    Flexible(
                        child: isRep
                            ? stepsController
                                .changeRepStep(stepsController.repCurrentStep)
                            : stepsController
                                .changeStep(stepsController.currentStep)),

                    //Despliegue de Shopping Cart
                    if (!mobile(context)) const CartWidget()
                  ]),
                )
              ],
            ),
          );
        });
  }
}
