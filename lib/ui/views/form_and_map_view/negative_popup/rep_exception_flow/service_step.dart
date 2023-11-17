import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/popup_controller.dart';
import '../../positive_popup/plan_type_step.dart';
import '../../parse_methods.dart';

class ServiceStep extends StatelessWidget {
  const ServiceStep({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final controller = Provider.of<PopupController>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Selected location: ',
              style: GoogleFonts.poppins(
                fontSize: mobile ? 13 : 18,
                height: 1,
                color: const Color(0xff001E4D),
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: parseLocation(controller.customerInfo.locationGroup),
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 13 : 18,
                    height: 1,
                    color: const Color(0xffd20030),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "\nSelected technology: ",
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 13 : 18,
                    height: 1,
                    color: const Color(0xff001E4D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: parseServiceType(controller.customerInfo.coverageType),
                  style: GoogleFonts.poppins(
                    fontSize: mobile ? 13 : 18,
                    height: 1,
                    color: const Color(0xffd20030),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ]),
        ),
        const SizedBox(height: 20),
        const PlanTypeStep()
      ],
    );
  }
}
