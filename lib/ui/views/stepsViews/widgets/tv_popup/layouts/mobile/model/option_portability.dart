import 'package:flutter/material.dart';

class OptionPortability {
  final int id;
  final IconData icon;
  bool? isSelected;

  OptionPortability({
   required this.id,
   required this.icon,
   this.isSelected
   });
}

List<OptionPortability> optionsPortability = [
  OptionPortability(id: 0, icon: Icons.checklist_rtl_outlined, isSelected: true),
  OptionPortability(id: 1, icon: Icons.file_present_outlined, isSelected: false),
];
