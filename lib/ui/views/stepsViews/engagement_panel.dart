import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/widgets/engage_form_field.dart';

class EngagementPanel extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const EngagementPanel({Key? key, required this.formKey}) : super(key: key);

  @override
  State<EngagementPanel> createState() => _EngagementPanelState();
}

class _EngagementPanelState extends State<EngagementPanel> {
  @override
  Widget build(BuildContext context) {
    const int maxAppWidth = 1800;
    final respSize = MediaQuery.of(context).size;
    var appwidth = respSize.width < maxAppWidth ? respSize.width : maxAppWidth;
    double? headerfontSize = lerpDouble(18, 20, (appwidth - 500) / maxAppWidth);
    double? bodyfontSize = lerpDouble(14, 16, (appwidth - 500) / maxAppWidth);
    final customerController = Provider.of<CustomerInfoProvider>(context);

    Color panelColor = colorPrimary;
    final view = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text('How did you hear about UWIFI?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: colorInversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: headerfontSize! - 2,
                    )),
              ),
            ],
          ),
          Text('Please select one:',
              style: GoogleFonts.workSans(
                  color: colorInversePrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: bodyfontSize,
                  height: 2.5)),
          EngageFormField(formKey: widget.formKey)
        ]);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 10, 8),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: view,
      ),
    );
  }
}
