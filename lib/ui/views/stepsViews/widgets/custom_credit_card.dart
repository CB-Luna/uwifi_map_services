import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

import '../../../../providers/customer_pd_sd_cc_provider.dart';

class CustomCreditCard extends StatelessWidget {
  const CustomCreditCard({Key? key}) : super(key: key);

  //El slider de extensiones sigue pendiente
  @override
  Widget build(BuildContext context) {
    final customerPDSDCCController = Provider.of<CustomerPDSDCCProvider>(context);
    bool isCvvFocused = false;

    return SizedBox(
      height: 230,
      width: 400,
      child: CreditCardWidget(
        cardBgColor: colorSecondary,
        cardNumber: customerPDSDCCController.number.text,
        expiryDate: customerPDSDCCController.date.text,
        cardHolderName: customerPDSDCCController.cardName.text,
        cvvCode: customerPDSDCCController.cvv.text,
        isHolderNameVisible: true,
        showBackView: isCvvFocused,
        onCreditCardWidgetChange:
            (CreditCardBrand creditCardBrand) {
            },
        glassmorphismConfig: Glassmorphism(
          blurX: 8.0, 
          blurY: 16.0, 
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                colorSecondary,
                colorSecondary.withAlpha(200),
              ],
              stops: const <double>[
                0.3,
                0,
              ],
            )),
        enableFloatingCard: true,
        floatingConfig: const FloatingConfig(
          isGlareEnabled: true,
          isShadowEnabled: true,
          shadowConfig: FloatingShadowConfig(),
        ),
        ),
    );
  }

}
