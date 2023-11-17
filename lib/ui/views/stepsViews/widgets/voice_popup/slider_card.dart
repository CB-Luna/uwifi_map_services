import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/slider_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/switch_widget.dart';

class SliderCard extends StatelessWidget {
  final String id;
  final String name;
  final int index;
  final String category;
  final String description;
  final double basePrice;
  final double maxValue;

  const SliderCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.index,
      required this.category,
      required this.description,
      required this.basePrice,
      required this.maxValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: mobile ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(mobile ? 0.0 : 15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(name,
                  style: GoogleFonts.workSans(
                      fontSize: 14,
                      color: const Color(0xFF2e5899),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2)),
              maxValue > 1 ?
              SliderWidget(
                  id: id,
                  basePrice: basePrice,
                  category: category,
                  index: index,
                  maxValue: maxValue,
                  productName: name)
              :
              SwitchWidget(
                id: id, 
                name: name,
                basePrice: basePrice, 
                category: category, 
                index: index, 
                maxValue: maxValue, 
                productName: name),
            ]));
  }
}
