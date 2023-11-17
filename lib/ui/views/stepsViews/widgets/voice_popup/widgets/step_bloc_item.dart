import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/data/constants.dart';

class StepBlocItem extends StatelessWidget {
  final String stepNumber;
  final String description;

  //One learning - YOu cannot use Row here because of equal placements.. Table or reversing Row with Column will work. Let's see.

  const StepBlocItem({
    Key? key,
    required this.stepNumber,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 1000 ? true : false ;
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ClayContainer(
            height: 40,
            width: 40,
            depth: 15,
            borderRadius: 12,
            parentColor: Colors.white,
            curveType: CurveType.convex,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: iconBackgroundColorPortability , width: 1.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
      
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: iconBackgroundColorPortability , width: 0.8),
                ),
                child: Text(
                  stepNumber, 
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 12 : 15,
                    color: iconBackgroundColorPortability ,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF2e5899),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}