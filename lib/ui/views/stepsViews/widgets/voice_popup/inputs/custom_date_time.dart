import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/inputs/custom_inputs.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateTime extends StatefulWidget {
  final int index;

  const CustomDateTime({Key? key, required this.index}) : super(key: key);

  @override
  CustomDateTimeState createState() => CustomDateTimeState();
}

class CustomDateTimeState extends State<CustomDateTime> {
  DateTime? selectedDate;
  DateTime dateNow = DateTime.now();
  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final dateCharacters = RegExp(
        r'^(((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))[-/]?[0-9]{4}|02[-/]?29[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$');
    return TextFormField(
      readOnly: widget.index > 0 ? true : false,
      enabled: widget.index > 0 ? false : true,
      focusNode: FocusNode(), //Only tap event available
      enableInteractiveSelection: false, //Disable on change event
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      inputFormatters: [DateInputFormatter()],
      controller: portabilityFormProvider.requestedPortDateController,
      style: const TextStyle(color: Color(0xff324057)),
      decoration: CustomInputs.formInputDecoration(
        label: 'Port Date',
        icon: Icons.date_range_outlined,
        //maxWidth: 119
      ),
      validator: (value) {
        return (dateCharacters.hasMatch(value ?? ''))
            ? null
            : 'Enter a date MM/dd/yyyy';
      },
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              clipBehavior: Clip.antiAlias,
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Please select an available Date",
                      style: GoogleFonts.workSans(
                          color: const Color(0xff2E5899),
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    SfDateRangePicker(
                      showNavigationArrow: true,
                      onSelectionChanged: _onSelectionChanged,
                      initialSelectedDate: dateNow.weekday == 5
                          ? dateNow.add(const Duration(days: 9))
                          : dateNow.weekday == 6
                              ? dateNow.add(const Duration(days: 8))
                              : dateNow.add(const Duration(days: 7)),
                      enablePastDates: false,
                      maxDate: dateNow.add(const Duration(days: 50)),
                      selectionMode: DateRangePickerSelectionMode.single,
                      selectableDayPredicate: (DateTime dateTime) {
                        return dateTime.weekday == 6 ||
                                dateTime.weekday == 7 ||
                                dateTime.isBefore(
                                    dateNow.add(const Duration(days: 7)))
                            ? false
                            : true;
                      },
                    ),
                    CustomOutlinedButton(
                      onPressed: () {
                        if (selectedDate != null) {
                          formattedDate =
                              DateFormat("MM/dd/yyyy").format(selectedDate!);
                          portabilityFormProvider
                              .requestedPortDateController.text = formattedDate;
                          portabilityFormProvider
                              .changeValueRequestedPortDate();
                          Navigator.of(context).pop();
                        }
                      },
                      text: 'Accept',
                      bgColor: const Color(0xff2E5899),
                      borderColor: const Color(0xff2E5899),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
      } else if (args.value is DateTime) {
        selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
      } else {}
    });
  }
}
