import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';

class PopFinalPortabilityView extends StatelessWidget {
  const PopFinalPortabilityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final cartController = Provider.of<Cart>(context);
    return Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            width: 660,
            decoration: buildBoxDecoration(image: 'images/bg_gradient.png'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    'Thank you for making your portability proccess through RTA, now you can continue to finish the order ',
                    style: GoogleFonts.poppins(
                      fontSize: mobile ? 18 : 30,
                      height: 1.5,
                      color: const Color(0xff001E4D),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                CustomOutlinedButton(
                    onPressed: () {
                      if(!cartController.checkProductOnAdditionals(portabilityFormProvider.portabilityVoice.id)){
                          cartController.addAdditionalToCart(portabilityFormProvider.portabilityVoice);
                          portabilityFormProvider.portabilityCheck = true;
                        }
                        Navigator.of(context).pop();
                    },
                    text: 'Continue'),
              ],
            ),
          );
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}