import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';

import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_inputs.dart';

class PopNewFormNamePortability extends StatelessWidget {
  const PopNewFormNamePortability({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final nameCharacters = RegExp(r'^[a-zA-Z\- ]+$');
    final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return SingleChildScrollView(
            child: Container(
              width: 650,
              height: 300,
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: mobile ? 5 : 40),
              color: Colors.grey.shade300.withOpacity(0.5),
              child: Form(
                  key: portabilityFormProvider.newFormNameKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Portability Data Validation',
                        style: GoogleFonts.poppins(
                          fontSize: mobile ? 15 : 30,
                          height: 1.2,
                          color: const Color(0xff2E5899),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Please fill out the form with your personal info based on your current telephone bill',
                        style: GoogleFonts.poppins(
                          fontSize: mobile ? 13 : 25,
                          height: 1.5,
                          color: const Color(0xff001E4D),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Flexible(
                        child: TextFormField(
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            portabilityFormProvider.portFirstName = value;
                          },
                          validator: (value) {
                            return nameCharacters.hasMatch(value ?? '')
                            ? null
                            : 'Enter a valid name';
                          },
                          style: const TextStyle(color: Color(0xff324057)),
                          decoration: CustomInputs.formInputDecoration(
                              label: 'First Name',
                              icon: Icons.person_outlined,
                              //maxWidth: 119
                              ),
                        ),
                      ),

                       const SizedBox(
                        height: 20,
                      ),
                      //Last Name
                      Flexible(
                        child: TextFormField(
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            portabilityFormProvider.portLastName = value;
                          },
                          validator: (value) {
                            return nameCharacters.hasMatch(value ?? '')
                            ? null
                            : 'Enter a valid last name';
                          },
                          style: const TextStyle(color: Color(0xff324057)),
                          decoration: CustomInputs.formInputDecoration(
                              label: 'Last Name',
                              icon: Icons.person_outlined,
                              //maxWidth: 119
                              ),
                        ),
                      ),
          
                      const SizedBox(
                        height: 20,
                      ),

                      CustomOutlinedButton(
                      onPressed: () {
                        final isValid = portabilityFormProvider.validateNewFormName();
                          if (isValid) {
                            selectorSummaryController.changeView(4);
                          }
                      },
                      text: 'Accept',
                      bgColor: const Color(0xFFD20030),
                    ),
                      
                      
                      
                    ],
                  )),
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
//Un cambio