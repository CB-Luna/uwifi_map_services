import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/popup.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/minicart_tv.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/additional_tabs.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/channels_tabs.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/rta_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_channels_lineup.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_description.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_movie_channels_bundle.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_supported_devices.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_title.dart';

class TVDefaultDesktop extends StatelessWidget with Popup {
  final Plan plan;
  const TVDefaultDesktop({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final scrollControllerAllPopUp = ScrollController();
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
      constraints: getConstraints(
        context: context,
        height: 1152,
        width: 1142,
      ),
      decoration: buildBoxDecoration(
        image: 'images/tv_popup_bg.png',
        fit: BoxFit.fill,
      ),
      child: SingleChildScrollView(
        controller: scrollControllerAllPopUp,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Left Side
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  TVPopupTitle(
                    name: plan.name!,
                    featTitle: plan.featTitle!,
                    price: plan.price!.toString(),
                  ),
                  const SizedBox(height: 10),
                  TVPopupDescription(
                      description: plan.description ?? 'No description'),
                  const SizedBox(height: 10),
                  TVPopupChannelsLineup(
                    id: plan.id,
                  ),
                  const SizedBox(height: 10),
                  const TVPopupSupportedDevices(),
                  const SizedBox(height: 10),
                  cartController.isSupportedDevicesVisible
                      ? const TVPopupSetTopBox()
                      : RTASetTopBox(idTV: plan.id),
                ],
              ),
            ),
            const Spacer(),
            //Right Side
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      TVPopupMovieChannelsBundle(idTV: plan.id),
                      const SizedBox(
                        width: 10,
                      ),
                      AdditionalTabs(idTV: plan.id),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ChannelTabs(id: plan.id),
                ],
              ),
            ),
            const Spacer(),
            // Minicart
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: IconButton(
                        splashRadius: 10.0,
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xff8aa7d2),
                          size: 18,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const MiniCartTV(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
