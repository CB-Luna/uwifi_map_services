import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/providers/customer_pd_sd_cc_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
class CustomListTileSD extends StatelessWidget {
  final Place place;
  const CustomListTileSD({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final customerPDSDController = Provider.of<CustomerPDSDCCProvider>(context);

    //Extract street number
    final RegExp regex = RegExp(r'^([0-9]+)(\s+.*)?$');
    final RegExpMatch? match = regex.firstMatch(customerPDSDController.streetSD);
    final String streetNumber = match?.group(1) ?? '';

    return ListTile(
      leading: const Icon(
        Icons.location_on_outlined,
        color: colorPrimaryLight,
      ),
      title: streetNumber != ''
          ? Text('$streetNumber ${place.address}')
          : Text(place.address),
      onTap: () {
        customerPDSDController.pickPlaceSD(place, streetNumber);
        customerPDSDController.clearPlacesSD();
      },
      hoverColor: colorBgLight,
    );
  }
}
