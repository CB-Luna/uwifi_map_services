import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/buttons/custom_outlined_button.dart';

class FileUpLoadButton extends StatelessWidget {
  const FileUpLoadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final bool mobile = size.width < 500 ? true : false;
  final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
  final selectorSummaryController = Provider.of<SelectorSummaryController>(context);
  return FormField(
     autovalidateMode: AutovalidateMode.onUserInteraction,
     builder: (state) {
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        mobile ? 
        Column(
          children: [
            CustomOutlinedButton(
              onPressed: () {
                portabilityFormProvider.pickFiles();
              },
              text:  'Upload Last Bill' 
              ),
              const SizedBox(height: 10,),
              CustomOutlinedButton(
              onPressed: () {
                selectorSummaryController.changeView(8);
              },
              text:'Take a picture'
              ),
          ],
        )
        :
        CustomOutlinedButton(
          onPressed: () {
            portabilityFormProvider.pickFiles();
          },
          text: 'Upload Last Bill'
        ),
        const SizedBox(height: 10,),
        portabilityFormProvider.fileSelected ? Text(portabilityFormProvider.fileName, 
                style: GoogleFonts.workSans(
                color: const Color(0xff2E5899),
                fontWeight: FontWeight.w500,
                fontSize: 12))
                : Text('No file Selected', 
                style: GoogleFonts.workSans(
                color: const Color(0xff2E5899),
                fontWeight: FontWeight.w500,
                fontSize: 12)),
        Text(
          state.errorText ?? '',
          style: const TextStyle(
          color: Color(0xFFd74141), 
          fontSize: 11,
          )
        ),
        // fileNameWidget(result)
      ],
    );
     },
  );

  }
  

  
}