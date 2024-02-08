import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

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
          final stepsController = Provider.of<StepsController>(context);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: mobile(context)
                ? const NavigationMobile()
                : null,
            key: _scaffoldKey,
            backgroundColor: colorBgWhite,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const TopBar(),
                Expanded(
                  child: stepsController
                    .changeStep(stepsController.currentStep),
                )
              ],
            ),
          );
        });
  }
}
