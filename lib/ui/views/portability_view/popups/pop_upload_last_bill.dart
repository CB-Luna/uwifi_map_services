import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/portability_view/buttons/fileupload_button.dart';

class PopUploadLastBill extends StatelessWidget {
  const PopUploadLastBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      height: 405,
      width: 660,
      decoration: buildBoxDecoration(image: 'images/blue_circles.png'),
      child: Form(
        key: portabilityFormProvider.upLoadBillKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Text(
              ' last telephone bill in pdf format or image (jpg/png)',
              style: GoogleFonts.poppins(
                fontSize: mobile ? 14 : 25,
                height: 1.4,
                color: const Color(0xff2E5899),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '*Please make sure your invoice has the following information:\n•Account name\n•Matching address\n•Account number\n•List all phone numbers being ported to RTA',
              style: GoogleFonts.poppins(
                fontSize: mobile ? 10 : 12,
                color: const Color(0xff001E4D),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            // Upload Button
            const FileUpLoadButton(),

            const SizedBox(height: 8),

            portabilityFormProvider.fileSelected
                ? Text(
                    "*Thank you for upload your last telephone bill, you can continue",
                    style: GoogleFonts.poppins(
                      fontSize: mobile ? 10 : 12,
                      color: const Color(0xff001E4D),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "*If you don't have your last telephone bill, you can skip this step and continue. You'll can upload later on https://rtatel.com/",
                    style: GoogleFonts.poppins(
                      fontSize: mobile ? 10 : 12,
                      color: const Color(0xff001E4D),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

            const SizedBox(height: 10),

            CustomOutlinedButton(
                onPressed: () {
                  selectorSummaryController.changeView(2);
                },
                text: 'Continue'),
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}
