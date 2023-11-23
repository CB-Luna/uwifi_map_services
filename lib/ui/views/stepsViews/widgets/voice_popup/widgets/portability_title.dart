import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';

class PortabilityTitle extends StatelessWidget {
  const PortabilityTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 910 ? true : false;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'images/rta_logo.png',
                fit: BoxFit.contain,
                width: mobile ? 100 : 150,
                height: mobile ? 50 : 75,
              ),
              const Spacer(),
              Visibility(
                visible: mobile,
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25.0)),
                        border: Border.all(
                          color: const Color(0xFF2e5899),
                          width: 2.0,
                        ),
                      ),
                      child: badge.Badge(
                        badgeContent: Text(
                            portabilityFormProvider.fields.length.toString(),
                            style: const TextStyle(color: Colors.white)),
                        showBadge:
                            portabilityFormProvider.telephoneNumber[0].isEmpty
                                ? false
                                : true,
                        badgeColor: const Color(0xFFD20030),
                        position: badge.BadgePosition.bottomStart(),
                        elevation: 4,
                        child: IconButton(
                            padding: const EdgeInsets.all(0),
                            iconSize: 15,
                            color: const Color(0xFF2e5899),
                            icon: const Icon(Icons.view_agenda),
                            onPressed: () {
                              selectorSummaryController
                                  .changePortabilityMobileView(1);
                            }),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
              Container(
                height: mobile ? 30 : 35,
                width: mobile ? 30 : 35,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  border: Border.all(
                    color: const Color(0xFF2e5899),
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  iconSize: mobile ? 15 : 18,
                  color: const Color(0xFF2e5899),
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    portabilityFormProvider.clearInformationPortability();
                    portabilityFormProvider.portabilityCheck = false;
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            child: Text('Portability Authorization Letter Info',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
