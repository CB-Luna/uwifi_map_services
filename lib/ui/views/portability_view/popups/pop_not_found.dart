import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../buttons/custom_outlined_button.dart';
import '../../form_and_map_view/wigdets/gradient_button.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../../../../providers/referal_providers/portability_form_provider_r.dart';

class PopNotFound extends StatelessWidget {
  const PopNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final referralProvider =
        Provider.of<PortabilityFormProviderR>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(10),
      height: 400,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Unfortunately, we could not find an account registered to you. Please call customer service.",
            style: GoogleFonts.workSans(
              fontSize: 18,
              height: 1.5,
              color: const Color(0xff436aa5),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Please call now to get more information!',
            style: GoogleFonts.workSans(
              fontSize: 18,
              height: 1.5,
              color: const Color(0xff436aa5),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          //const PhoneNumberWidget(),
          GradientButtonWidget(
            function: () =>
                // ignore: deprecated_member_use
                url_launcher.launch("tel:+1${referralProvider.localPhone}"),
            text: referralProvider.localPhone,
          ),
          const SizedBox(height: 20),
          CustomOutlinedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Close'),
        ],
      ),
    );
  }
}
