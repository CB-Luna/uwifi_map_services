import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class StepperWidget extends StatelessWidget {
  final double width;
  final List<IconData> icons = [
    MdiIcons.cartOutline,
  ];
  final int curStep;
  final Color activeColor;
  final Color? inactiveColor = Colors.grey[100];
  final double lineWidth = 4.0;

  StepperWidget({
    Key? key,
    required this.curStep,
    required this.width,
    required this.activeColor,
  })  : assert(width > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Column(
          children: <Widget>[
            Row(
              children: iconViews(),
            ),
          ],
        ));
  }

  List<Widget> iconViews() {
    var list = <Widget>[];
    icons.asMap().forEach((i, icon) {
      //colors according to state
      var circleColor = (i == 0 || curStep > i) ? activeColor : Colors.white;

      var lineColor = curStep > i ? activeColor : inactiveColor;

      var iconColor = (i == 0 || curStep > i) ? inactiveColor : activeColor;

      list.add(
        //dot with icon view
        Row(
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: circleColor,
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                border: Border.all(
                  color: activeColor,
                  width: 2.0,
                ),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 18.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: colorBgBlack,
                  fontSize: 18.0,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );

      //line between icons
      if (i != icons.length - 1) {
        list.add(Expanded(
            child: Container(
          height: lineWidth,
          color: lineColor,
        )));
      }
    });

    return list;
  }
}
