import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

import 'package:uwifi_map_services/providers/customer_info_controller.dart';

class EngageFormField extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const EngageFormField({Key? key, required this.formKey}) : super(key: key);

  @override
  State<EngageFormField> createState() => _EngageFormFieldState();
}

class _EngageFormFieldState extends State<EngageFormField> {
  String? selectedopt;
  String? option;

  final List<Map<String, dynamic>> _opcionespc = [
    {
      'value': 'Billboard',
      'label': ' Billboard',
      'icon': const Icon(Icons.call_to_action_outlined),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Drive By',
      'label': ' Drive By',
      'icon': const Icon(Icons.garage),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Email',
      'label': ' Email',
      'icon': const Icon(Icons.email),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Facebook',
      'label': ' Facebook',
      'icon': const Image(
        image: AssetImage('images/facebook.png'),
        height: 16,
        fit: BoxFit.contain,
      ),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Google Search',
      'label': ' Google Search',
      'icon': const Image(
        image: AssetImage('images/google.png'),
        height: 18,
        fit: BoxFit.contain,
      ),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Instagram',
      'label': ' Instagram',
      'icon': const Image(
        image: AssetImage('images/instagram.png'),
        height: 18,
        fit: BoxFit.contain,
      ),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Neighbor/Friend',
      'label': ' Neighbor/Friend',
      'icon': const Icon(Icons.person_pin),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Post Card',
      'label': ' Postcard',
      'icon': const Icon(Icons.mark_as_unread_outlined),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Website',
      'label': ' Website',
      'icon': const Icon(Icons.monitor),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Yard Sign',
      'label': ' Yard Sign',
      'icon': const Icon(Icons.signpost),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'YouTube',
      'label': ' YouTube',
      'icon': const Image(
        image: AssetImage('images/youtube.png'),
        height: 16,
        fit: BoxFit.contain,
      ),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Church Offer',
      'label': ' Church Offer',
      'icon': const Icon(Icons.church_outlined),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Twitter',
      'label': ' Twitter',
      'icon': const Image(
        image: AssetImage('images/twitter.png'),
        height: 16,
        fit: BoxFit.contain,
      ),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'TV',
      'label': ' TV',
      'icon': const Icon(Icons.tv),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Radio',
      'label': ' Radio',
      'icon': const Icon(Icons.radio),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
    {
      'value': 'Event',
      'label': ' Event',
      'icon': const Icon(Icons.event),
      'textStyle': GoogleFonts.workSans(
        color: const Color(0xFF2E5899),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      )
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final customerController = Provider.of<CustomerInfoProvider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF).withOpacity(0.92),
              borderRadius: BorderRadius.circular(20)),
          child: Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                SelectFormField(
                  enabled: true,
                  type: SelectFormFieldType.dropdown,

                  controller: customerController.engageSelect,
                  autovalidate: true,
                  autofocus: true,
                  style: GoogleFonts.workSans(
                    color: const Color(0xFF2E5899),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                  // initialValue: selectedopt,

                  changeIcon: true,
                  // enableSearch: true,

                  hintText: 'None',
                  items: _opcionespc,
                  onChanged: (opt) {
                    customerController.setColor(const Color(0xFF2e5899));
                    // setState(() => selectedopt = opt);
                    customerController.setEngage(opt);

                    if (customerController.engageSelect.text ==
                        "Neighbor/Friend") {
                      showDialog(
                          barrierColor:
                              const Color(0x00022963).withOpacity(0.40),
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height / 13.5),
                              child: Dialog(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(29)),
                                clipBehavior: Clip.antiAlias,
                                child: const Center(
                                  child: null,
                                ),
                              ),
                            );
                          });
                    }
                  },
                  validator: (val) {
                    if (val == '') {
                      return 'Please select one';
                    } else {
                      return null;
                    }
                  },
                  // (val) => val == '' ? 'Please select one' : null,
                  icon: const Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
