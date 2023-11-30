import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/widgets/step_bloc_item.dart';

class SignFormView extends StatelessWidget {
  const SignFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 1000 ? true : false;
    return Form(
      key: portabilityFormProvider.signFormKey,
      child: Container(
        // color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You can go back to modify your data before continue to sign the letter',
                style: GoogleFonts.poppins(
                  fontSize: mobile ? 15 : 22,
                  height: 1.5,
                  color: const Color(0xff2E5899),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'If already your all information is okay, read the next steps:',
                style: GoogleFonts.poppins(
                  fontSize: mobile ? 12 : 15,
                  height: 1.5,
                  color: const Color(0xff001E4D),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const StepBlocItem(
                  stepNumber: "1",
                  description:
                      "Click on the red buttom below 'Continue to Sign', you will redirect to another tab where displays whole Letter of Authorization."),
              const StepBlocItem(
                  stepNumber: "2",
                  description:
                      "Accept the Terms of use clicking on blue button 'Continue'."),
              const StepBlocItem(
                  stepNumber: "3",
                  description:
                      "The Letter shows your input information, so just search the sign area with the label 'Click here to sign'."),
              const StepBlocItem(
                  stepNumber: "4",
                  description:
                      "A new popup will display, next typing or drawing your signature and click on blue button 'Apply'."),
              StepBlocItem(
                  stepNumber: "5",
                  description:
                      "Click on the blue button 'Click to Sign' and write the same email address that you input previously in the section Personal Details. This one: ${portabilityFormProvider.portEmail}"),
              const StepBlocItem(
                  stepNumber: "6",
                  description:
                      "Click on the blue button 'Click to sign', verify and confirm the mail that you will receive, you even can print the copy of letter if you want."),
              const StepBlocItem(
                  stepNumber: "7",
                  description:
                      "Finally click on the below red button 'Continue' to move on next step."),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}





//Un cambio