import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_supported_devices.dart';

class RTASetTopBox extends StatelessWidget {
  final String idTV;
  const RTASetTopBox({Key? key, required this.idTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final bool desktop = size.width > 1350 ? true : (size.width > 880 ? false : true);
    int index = 0;
    
    String id = tvPopupController.tvDevices[idTV]![index].id;
    String name = tvPopupController.tvDevices[idTV]![index].name;
    double cost = double.parse(tvPopupController.tvDevices[idTV]![index].price);
    String image = tvPopupController.tvDevices[idTV]![index].picture;
    Product device = Product(
      id: id,
      name: name, 
      cost: cost, 
      imageurl: image, 
      service: tvPopupController.tvDevices[idTV]![index].family,
      category: tvPopupController.tvDevices[idTV]![index].categories[0],
      isSelected: false,
      quantity: 0, 
      pwName: tvPopupController.tvDevices[idTV]![index].pwName,
      );
      if (cartController.devices.isEmpty) {
        cartController.devices.add(device);
      }
    
    return desktop ? Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCardSupportedDevices(index: index, name: name, cost: cost, image: image),
        const SizedBox(width: 10),
        Text(
          "Note: This will need\nto be returned\ndisconnect. If not\nreturned a \$150 free\nis assessed.",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 10,
            color: const Color(0xFF8AA7D2),
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
      ],
    )
    :
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCardSupportedDevices(index: index, name: name, cost: cost, image: image),
        const SizedBox(height: 10),
        Text(
          "Note: This will need\nto be returned\ndisconnect. If not\nreturned a \$150 free\nis assessed.",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 10,
            color: const Color(0xFF8AA7D2),
            fontWeight: FontWeight.normal,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}