import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';

class CustomCardAdditionalRecording extends StatelessWidget {
  final int index; 
  final String name;
  final double cost;
  const CustomCardAdditionalRecording({
    Key? key,
    required this.index,
    required this.name,
    required this.cost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Cart>(context);
    bool isSelected = controller.additionalsRecording[index].isSelected!;
    return GestureDetector(
      onTap:(){
        controller.changeSelectedAdditionalsRecording(index);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 80,
          width: 100,
          child: Stack(
          children: [
              Card(
                color: Colors.white,
                elevation: 4,
                shape: getDecoration(isSelected),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                        fontSize: name.length > 54 ? 7 : 8,
                        height: 1,
                        color: const Color(0xff2E5899),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '\$$cost/mo',
                      style: GoogleFonts.workSans(
                        fontSize: 22,
                        height: 2,
                        color: const Color(0xff2E5899),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: isSelected ? 
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                        color: Color(0xFFD20030),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(12)),
                      ),
                  child: 
                      const Center(
                        child: Icon(Icons.check,
                        color: Colors.white,
                        size: 15,
                        ),
                      )
                )
                :
                const SizedBox(
                  height: 20,
                  width: 20,
                  // decoration: BoxDecoration(
                  //       border: Border.all(color: const Color(0xFFD20030)),
                  //       borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(20),
                  //         bottomRight: Radius.circular(12)),
                  //     ),
                  child: Icon(Icons.circle_outlined,
                      color: Color(0xFF101E51),
                      size: 10,
                      )
                ),
              )
          ]),
        ),
      ),
    );
  }

  RoundedRectangleBorder getDecoration(isSelected) {
    late final Color borderColor;
    if (isSelected) {
      borderColor = const Color(0xFFD20030);
    } else {
      borderColor = Colors.white;
    }
    return RoundedRectangleBorder(
    side: BorderSide(
            color: borderColor,
            width: 1.5,
          ),
    borderRadius: BorderRadius.circular(12.0));
  }
}