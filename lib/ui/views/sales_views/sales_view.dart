import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';
import 'package:uwifi_map_services/ui/views/sales_views/version_customer/step_plans/plans_listview_customer.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/plans_listview.dart';
import '../../../data/constants.dart';

class SalesView extends StatefulWidget {
  final String serviceType;
  const SalesView({Key? key, required this.serviceType}) : super(key: key);

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PlanController>(context);
    final customerController = Provider.of<CustomerInfoProvider>(context);

    final bool isRep = customerController.customerInfo.customerRep != "";

    final ScrollController scrollController = ScrollController();

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 25),
      margin: EdgeInsets.all(isRep || mobile(context) ? 0 : 20),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text("Build your ${widget.serviceType} plan",
            textAlign: TextAlign.center, style: subtitleStyle(context)),
        const SizedBox(height: 25),
        Flexible(
          child: SizedBox(
            width: double.infinity,
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                scrollDirection:
                    isRep || !mobile(context) ? Axis.horizontal : Axis.vertical,
                child: isRep
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var category in controller.plansCategories)
                            PlansListView(category: category)
                        ],
                      )
                    : Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          for (var category in controller.plansCategories)
                            mobile(context)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 25, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: colorsTheme(context)
                                          .inversePrimary
                                          .withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 30,
                                          spreadRadius: -20,
                                          color: colorsTheme(context)
                                              .inversePrimary
                                              .withOpacity(0.15),
                                          offset: const Offset(0, 20),
                                        )
                                      ],
                                    ),
                                    child: PlansListViewCustomer(
                                        category: category))
                                : PlansListViewCustomer(category: category),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
