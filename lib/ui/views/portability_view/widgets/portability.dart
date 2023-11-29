import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/create_contract.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/portability_mobile.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/portability_title_contract.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/segment_contract.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/widgets/portability_title.dart';

class Portability extends StatelessWidget {
  final Widget child;

  const Portability({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return  Container(child: chooseBody(size, child));
  }

  Widget chooseBody(size, child) {
  if (size.width > 910) {
    return _DesktopBody(child: child);
  } else {
    return _MobileBody(child: child);
  }
}

}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: backgroundColorPortability,
      child: Builder(builder: (context) {
              final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
              switch (selectorSummaryController.currentPortMobileView) {
                case MobilePortability.portMobileView:
                  return selectorSummaryController.currentPortabilityView != StepsPortability.signView ? SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        const PortabilityTitle(),
                        child,
                        const SizedBox(height: 15,),
                        SizedBox(
                          width: size.width * 0.85, 
                          child: const SegmentContract()
                          )]),
                  )
                  :
                  PortabilityMobile(child: child);
                case MobilePortability.contractView:
                  return SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        const PortabilityTitleContract(),
                        SizedBox(
                              width: size.width * 0.85,
                              height: size.height * 0.7,
                              child: const CreateContract(),
                        ),
                      ],
                    ),
                  );
                default:
                  return selectorSummaryController.currentPortabilityView != StepsPortability.signView ? SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        const PortabilityTitle(),
                        child,
                        const SizedBox(height: 15,),
                        SizedBox(
                          width: size.width * 0.85, 
                          child: const SegmentContract()
                          )]),
                  )
                  :
                  PortabilityMobile(child: child);
                }
             }),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    //como el listview requiere que todos sus hijos tengan el mismo tamaño para
    //hacer scroll, el container debe tener un tamaño especifico
    return Container(
      width: size.width,
      height: size.height,
      color: backgroundColorPortability,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 600, 
            child: CreateContract()),
          //View container
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  const PortabilityTitle(),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}