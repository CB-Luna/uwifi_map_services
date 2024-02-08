import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart_buttons_views.dart';

class NavigationMobile extends StatelessWidget {
  const NavigationMobile({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: colorBgWhite,
        ),
        padding: const EdgeInsets.all(15.0),
        child: styledButton(context));
  }
}
