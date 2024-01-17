import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/customer_ssn_acp_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class Step1ACPSSNForm extends StatefulWidget {
  const Step1ACPSSNForm({Key? key}) : super(key: key);

  @override
  State<Step1ACPSSNForm> createState() => _Step1ACPSSNFormState();
}

class _Step1ACPSSNFormState extends State<Step1ACPSSNForm> {
  TextEditingController number = TextEditingController(text:"");
  TextEditingController ccv = TextEditingController(text:"");
  TextEditingController date = TextEditingController(text:"");
  TextEditingController cardName = TextEditingController(text:"");
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    final customerSSNACPController = Provider.of<CustomerSSNACPProvider>(context);
    final acpCharacters = RegExp(r'\d{6}-\d{4}');
    final ssn4Characters = RegExp(r'-\d{4}');
    var acpFormat = MaskTextInputFormatter(
      mask: '######-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    var ssn4Format = MaskTextInputFormatter(
      mask: '-####',
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    final isMobile = MediaQuery.of(context).size.width < 1024 ? true : false;
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.person_outline,
                    color: colorInversePrimary,
                    size: isMobile ? 25 : 40,
                  ),
                ),
                Text(
                  customerSSNACPController.acpNumberR ? 
                    'SSN' :
                    'ACP Number',
                  style: TextStyle(
                    color: colorInversePrimary,
                    fontSize: isMobile ? 18 : 26,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    "I don't remember my ACP Number",
                    style: GoogleFonts.workSans(
                    fontSize: isMobile ? 12 : 16,
                    color: colorInversePrimary,
                    fontWeight: FontWeight.normal)),
                ),
                Flexible(
                  flex: 1,
                  child: Checkbox(
                    side: const BorderSide(
                      color: colorBgWhite,
                      width: 2.0
                    ),
                    activeColor: colorBgWhite,
                    value: customerSSNACPController.acpNumberR,
                    onChanged: (bool? value) {
                      customerSSNACPController.changeRemeberACPNumber();
                    },
                  ),
                ),
              ],
            ),
          ),
          Form(
              key: customerSSNACPController.formKeySSNACP,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 400,
                      child: TextFormField(
                        /// VARIABLE STORAGE
                        controller: customerSSNACPController.acpNumberR ?
                        customerSSNACPController.ssn4LD :
                         customerSSNACPController.acpNumber,
                        ///VALIDATION TRIGGER
                        autovalidateMode: AutovalidateMode
                            .onUserInteraction,
                        autocorrect: false,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        decoration: CustomInputs()
                            .formInputDecoration(
                                label: customerSSNACPController.acpNumberR ? 
                                '4 Last Digits*' :
                                'Number*',
                                icon: Icons.numbers_outlined,
                                maxHeight: 55),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(customerSSNACPController.acpNumberR ? 5 : 11),
                        customerSSNACPController.acpNumberR ? ssn4Format : acpFormat
                      ],
                      validator: (value) {
                        return customerSSNACPController.acpNumberR ? 
                          (ssn4Characters
                                .hasMatch(value ?? '')
                            ? null
                            : 'Please enter your last 4 SSN digits')
                          :
                          (acpCharacters
                                .hasMatch(value ?? '')
                            ? null
                            : 'Please enter your ACP number');
                      },
                      style: const TextStyle(
                        color: colorBgWhite,
                      ),
                                                ),
                    ),
                  ),
              ],
                         )),
        ]);
  }
}
