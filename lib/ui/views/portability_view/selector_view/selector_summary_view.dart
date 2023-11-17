import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/views/portability_view/selector_view/popup_selector_summary.dart';

void selectorSummaryview(BuildContext context) {
  
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return const PopupSelectorSummary();
          },
        );
    
}


