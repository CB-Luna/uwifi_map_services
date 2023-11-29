import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/segment_contract.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option_portability.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/widgets/portability_title.dart';

const Color iconBackgroundColor =  Color(0xFF647082);
final BorderRadius optionBorderRadius = BorderRadius.circular(8);

class PortabilityMobile extends StatelessWidget {
  final Widget child;
  const PortabilityMobile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          const PortabilityTitle(),
          const SizedBox(
            height: 5,
          ),
          _SettingAndOptions(),
          const SizedBox(
            height: 5,
          ),
          _ContainerSettingAndOptions(child: child,),
          const SizedBox(height: 5,),
          ]),
    );
  }
}

class _ContainerSettingAndOptions extends StatelessWidget{
  final Widget child;
  const _ContainerSettingAndOptions({Key? key, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return Builder(builder: (context) {
      switch (portabilityFormProvider.indexContainer) {
        case 0:
          return child;
        case 1:
          return SizedBox(
            width: size.width * 0.85, 
            child: const SegmentContract()
            );  
        default:
          return child;  
      }
    });
  }
}


class _SettingAndOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12),
      child: Row(
        children: const <Widget>[
           _OptionsWidget(
              ), 
        ],
      ),
    );
  }
}

class _OptionsWidget extends StatelessWidget {

  const _OptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int index = 0; index < optionsPortability.length; index++)
          _OptionWidget(
              option: optionsPortability[index],
              index: index),
      ],
    );
  }
}

class _OptionWidget extends StatelessWidget {
  final OptionPortability option;
  final int index;
  const _OptionWidget(
      {Key? key, required this.option, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
     final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return InkWell(
      onTap: () {
        portabilityFormProvider.selectedOptionsPortability(index);
        // tvPopupController.showActionSnackBar(context, index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          elevation: 8,
          borderRadius: optionBorderRadius,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: optionBorderRadius,
              color: optionsPortability[index].isSelected! ? const Color(0xFFD20030) : Colors.white,
            ),
            child: Icon(
              option.icon,
              color: optionsPortability[index].isSelected! ? Colors.white : iconBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

}