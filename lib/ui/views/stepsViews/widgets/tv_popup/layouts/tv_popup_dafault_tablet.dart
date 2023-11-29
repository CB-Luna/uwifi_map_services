import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/popup.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/minicart_tv.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/circular_taps_menu.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/additional_tabs_mobile.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/rta_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_channels_lineup.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_description.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_movie_channels_bundle.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_supported_devices.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_title.dart';

class TVDefaultTablet extends StatelessWidget with Popup {
  final Plan plan;
  const TVDefaultTablet({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final scrollControllerAllPopUp = ScrollController();
    final scrollControllerProducts = ScrollController();
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
      constraints: getConstraints(
        context: context,
        height: 500,
        width: 700,
      ),
      decoration: buildBoxDecoration(
        image: 'images/tv_popup_bg.png',
        fit: BoxFit.fill,
      ),
      child: SingleChildScrollView(
        controller: scrollControllerAllPopUp,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              // Right Side
              Expanded(
                flex: 6,
                child: SizedBox(
                  width: 500,
                  height: 500,
                  child: Scrollbar(
                    controller: scrollControllerProducts,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: scrollControllerProducts,
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          TVPopupMovieChannelsBundle(idTV: plan.id),
                          const SizedBox(height: 10),
                          AdditionalTabsMobile(idTV: plan.id),
                          const SizedBox(width: 10),
                          CircularTapsMenu(idTV: plan.id),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // ChannelTabs(id: plan.id),
                ),
                // Text('Hola')
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
      ),
      // Text('Hola Mundo')
    );
  }
}
