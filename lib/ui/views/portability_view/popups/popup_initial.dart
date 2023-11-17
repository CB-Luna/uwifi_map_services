import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_options_info.dart';

void popUpInitial(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          clipBehavior: Clip.antiAlias,
          contentPadding: EdgeInsets.all(10),
          content:  PopOptionsInfo(),
        );
      });
}
