import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/shipping_info.dart';
import 'customer_info_checks.dart';
import 'package:uwifi_map_services/classes/popup.dart';

class CustomerLocationDisplay extends StatelessWidget with Popup {
  final String street;
  final String city;
  final String state;
  final String zcode;
  CustomerLocationDisplay({
    Key? key,
    required this.street,
    required this.city,
    required this.state,
    required this.zcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          //Shipping Info
          Container(
            height: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: colorBgWhite,
            ),
            child: const ShippingInfo(),
          ),
           const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
