import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/voice_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/voice_popup_default.dart';

class VoicePopup extends StatelessWidget {
  final Plan plan;
  final String customerType;
  const VoicePopup({Key? key, required this.plan, required this.customerType})
      : super(key: key);

  //El slider de extensiones sigue pendiente
  @override
  Widget build(BuildContext context) {
    final voicePopupController =
        Provider.of<VoicePopupController>(context, listen: false);
    voicePopupController.init();
    return AlertDialog(
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(0.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0))),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: FutureBuilder<String>(
            future: voicePopupController.getProductsVoice(
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
                  return VoiceDefault(
                    plan: plan,
                    customerType: customerType,
                  );
                }
              }
            }));
  }
}
