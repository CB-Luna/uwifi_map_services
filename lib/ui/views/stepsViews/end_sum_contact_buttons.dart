import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/customer_info_controller.dart';

class ContactButtons extends StatefulWidget {
  const ContactButtons({Key? key}) : super(key: key);

  @override
  State<ContactButtons> createState() => _ContactButtonsState();
}

class _ContactButtonsState extends State<ContactButtons> {
  final List<bool> _selections = List.generate(2, (index) => true);
  @override
  Widget build(BuildContext context) {
    final customerController = Provider.of<CustomerInfoProvider>(context);
    // customerController.contactByPhone = true;
    // customerController.contactByEmail = true;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80),
          child: FittedBox(
            child: ToggleButtons(
              isSelected: _selections,
              onPressed: (int index) {
                int count = 0;
                for (var val in _selections) {
                  if (val) count++;
                }

                if (_selections[index] && count < 2) return;

                setState(() {
                  _selections[index] = !_selections[index];
                });
                if (index == 0) {
                  customerController.contactByPhone = _selections[index];
                }
                if (index == 1) {
                  customerController.contactByEmail = _selections[index];
                }
              },
              color: Colors.grey,
              selectedColor: (Colors.white),
              fillColor: const Color(0xFFD20030),
              borderRadius: BorderRadius.circular(30),
              borderWidth: 2,
              hoverColor: const Color(0xFF8AA7D2),
              children: const [
                Icon(Icons.phone_outlined),
                Icon(Icons.mail_outline_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
