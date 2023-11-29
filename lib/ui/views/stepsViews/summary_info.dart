import 'package:flutter/material.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/inputs/custom_inputs.dart';

class SummaryInfo extends StatefulWidget {
  const SummaryInfo({Key? key}) : super(key: key);

  @override
  State<SummaryInfo> createState() => _SummaryInfoState();
}

class _SummaryInfoState extends State<SummaryInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_history_outlined,
                      color: colorPrimary,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Summary',
                      style: h2Style(context),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1.5,
                color: colorPrimaryDark,
              ),
              Flexible(
                child: Form(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                             Text("Address to be sent to"),
                             Text("Name of the person who is going to receive it"),
                             Text("Contact Info"),
                             Text("Extra information")
                          ]),
                    )),
              ),
      ],
    );
  }
}