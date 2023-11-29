import 'package:flutter/material.dart';
import 'package:uwifi_map_services/icons/my_flutter_app_icons.dart';

class Option {
  final int id;
  final IconData icon;
  bool? isSelected;

  Option({
   required this.id,
   required this.icon,
   this.isSelected
   });
}

List<Option> options = [
  Option(id: 0, icon: Icons.checklist_rtl_outlined, isSelected: true),
  Option(id: 1, icon: Icons.widgets_outlined, isSelected: false),
  Option(id: 2, icon: MyFlutterApp.dvr, isSelected: false),
  Option(id: 3, icon: Icons.queue_play_next_outlined, isSelected : false),
  Option(id: 4, icon: Icons.important_devices_outlined, isSelected : false),
];
