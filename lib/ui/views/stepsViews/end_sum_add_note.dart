import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';

class AddNotepad extends StatefulWidget {
  const AddNotepad({Key? key}) : super(key: key);

  @override
  AddNotepadState createState() => AddNotepadState();
}

class AddNotepadState extends State<AddNotepad> {
  String _enteredText = '';
  @override
  Widget build(BuildContext context) {
    final customerController = Provider.of<CustomerInfoProvider>(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 20, 8),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: const Color(0xFF2e5899),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  'Add a note for our representative',
                  textAlign: TextAlign.center,
                  style: h2Style(context, color: Colors.white),
                )),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 400,
                maxWidth: 900,
                minHeight: 20,
                maxHeight: 900,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _enteredText = value;
                      customerController.custNote = value;
                    });
                  },
                  maxLines: 2,
                  style: bodyStyle(context),
                  decoration: InputDecoration(
                      counterText: '${350 - _enteredText.length}',
                      hintText: "Enter a note"),
                  inputFormatters: [LengthLimitingTextInputFormatter(350)],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
