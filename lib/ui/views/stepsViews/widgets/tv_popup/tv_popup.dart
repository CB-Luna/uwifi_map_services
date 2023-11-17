import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart' as tvpc;
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/tv_popup_channels_mobile.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/tv_popup_minicart_mobile.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_default.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_channels.dart';
import 'package:provider/provider.dart';

import 'package:uwifi_map_services/classes/plan.dart';

class TVPopup extends StatelessWidget with Popup {
  final Plan plan;
  const TVPopup({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width <= 880 ? true : false;
    final tvPopupController =
        Provider.of<tvpc.TVPopupController>(context, listen: false);
    tvPopupController.init();

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: FutureBuilder<String>(
          future: tvPopupController.getPremiumChannelPacks(
              plan.id, plan.planCategory), // function where you call your api
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 250,
                width: 250,
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
                            color: color,
                            shape: BoxShape.circle,
                          ),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Builder(builder: (context) {
                  final tvPopupController =
                      Provider.of<tvpc.TVPopupController>(context);
                  switch (tvPopupController.currentView) {
                    case tvpc.View.planDetails:
                      return TVDefault(plan: plan);
                    case tvpc.View.channelLineup:
                      return mobile
                          ? ChannelsLineupMobile(id: plan.id)
                          : ChannelsLineup(id: plan.id);
                    case tvpc.View.miniCart:
                      return TVPopupMinicartMobile(plan: plan);
                    default:
                      return TVDefault(plan: plan);
                  }
                });
              }
            }
          }),
    );
  }
}
