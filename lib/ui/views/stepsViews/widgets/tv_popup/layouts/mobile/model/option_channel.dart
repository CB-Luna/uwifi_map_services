import 'package:flutter/material.dart';
import 'package:uwifi_map_services/icons/my_flutter_app_icons.dart';

class OptionChannel {
  final int id;
  final IconData icon;
  bool? isSelected;

  OptionChannel({
   required this.id,
   required this.icon,
   this.isSelected
   });
}

List<OptionChannel> optionsChannel = [
  OptionChannel(id: 0, icon: Icons.tv_outlined, isSelected: true),
  OptionChannel(id: 1, icon: Icons.sports_football_outlined, isSelected : false),
  OptionChannel(id: 2, icon: MyFlutterApp.news, isSelected : false),
  OptionChannel(id: 3, icon: Icons.theaters_outlined, isSelected : false),
  OptionChannel(id: 4, icon: Icons.music_note_outlined, isSelected : false),
  OptionChannel(id: 5, icon: MyFlutterApp.kids, isSelected : false),
];