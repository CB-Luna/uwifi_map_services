import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clay_containers/clay_containers.dart';

const Color iconBackgroundColor = Color.fromARGB(255, 8, 43, 95);
const Color backgroundColor = Color(0xFF2e5899);
class ViewFeaturesPackage extends StatelessWidget {
  final String idTV;
  final String description;
  const ViewFeaturesPackage({
    Key? key,
    required this.idTV, 
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String descriptionFiltered = description.replaceAll('・', '');
    List<String> listFeatures = descriptionFiltered.split('\n');
    return Column(
      children: [
        Text(
          'Features',
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 26,
            color: const Color(0xFF2e5899),
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff8AA7D2)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  for (var feature in listFeatures)
                    FeatureBlocItem(
                      iconData: Icons.check_circle_outline, 
                      description: feature),
                ],
              ),
            ),
          )      
      ],
    );
  }

}

class FeatureBlocItem extends StatelessWidget {
  final IconData iconData;
  final String description;

  //One learning - YOu cannot use Row here because of equal placements.. Table or reversing Row with Column will work. Let's see.

  const FeatureBlocItem({
    Key? key,
    required this.iconData,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                border: Border.all(color: backgroundColor, width: 1.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: backgroundColor, width: 0.8),
                ),
                child: Icon(
                  iconData,
                  color: iconBackgroundColor,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 180,
            child: Text(
              description,
              maxLines: 2,
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

