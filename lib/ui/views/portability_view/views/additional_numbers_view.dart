import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';


class AdditionalNumbersView extends StatelessWidget {
  const AdditionalNumbersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 800 ? true : false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Would you like to port additional numbers?',
          style: GoogleFonts.poppins(
            fontSize: mobile ? 20 : 25,
            height: 1.5,
            color: const Color(0xff001E4D),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
      ],
    );
      
  }

}