import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class ExpandedWidget extends StatefulWidget {
  final String title;
  final String text;
  final double boxPadding;
  bool isReadMore = false;

  ExpandedWidget(
      {Key? key,
      required this.title,
      required this.text,
      required this.boxPadding})
      : super(key: key);

  @override
  ExpandedWidgetState createState() => ExpandedWidgetState();
}

class ExpandedWidgetState extends State<ExpandedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 0.0,
            bottom: widget.boxPadding,
            right: widget.boxPadding,
            left: widget.boxPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                const WidgetSpan(
                  child: Icon(MdiIcons.alertCircleOutline,
                      size: 16.0, color: Color(0xFF8AA7D2)),
                ),
                TextSpan(
                  text: widget.title,
                  style: GoogleFonts.workSans(
                      fontSize: 13,
                      color: const Color(0xFF2e5899),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5),
                ),
              ]),
            ),
            Text(widget.text,
                maxLines: widget.isReadMore ? null : 2,
                overflow: widget.isReadMore
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: GoogleFonts.workSans(
                    height: 1.5,
                    fontSize: 10.5,
                    color: const Color(0xFF8AA7D2),
                    fontWeight: FontWeight.normal,
                    letterSpacing: -0.2)),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE77690),
                textStyle: const TextStyle(
                  fontSize: 12,
                ),
              ),
              onPressed: () =>
                  setState(() => widget.isReadMore = !widget.isReadMore),
              child: Text(widget.isReadMore ? 'Show less' : 'Learn more',
                  style: GoogleFonts.workSans(
                      height: 1.5,
                      fontSize: 12,
                      color: const Color(0xFFd20030),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2)),
            )
          ],
        ));
  }
}
