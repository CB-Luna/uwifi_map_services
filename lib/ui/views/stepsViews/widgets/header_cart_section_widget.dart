import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class HeaderCartSectionWidget extends StatelessWidget {
  const HeaderCartSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;
    return Container(
        width: MediaQuery.of(context).size.width * (isMobile ? 0.9 : 0.5),
        padding: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: colorBorder),
            ),
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Text(
                    'Cart Summary',
                    style: TextStyle(
                        color: colorBgDark,
                        fontSize: isMobile ? 18.0 : 27.0,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                    ),
                ),
            ],
        ),
    );
  }
}