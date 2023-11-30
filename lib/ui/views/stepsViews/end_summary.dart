// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/form_and_map_view/wigdets/gradient_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/end_sum_add_note.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/end_sum_personal.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/engagement_panel.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/final_popup.dart';

class EndSummaryWidget extends StatefulWidget {
  final String street;
  final String city;
  final String state;
  final String zipcode;

  const EndSummaryWidget(
      {Key? key,
      required this.street,
      required this.city,
      required this.state,
      required this.zipcode})
      : super(key: key);
  @override
  EndSummaryWidgetState createState() => EndSummaryWidgetState();
}

class EndSummaryWidgetState extends State<EndSummaryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final customerController = Provider.of<CustomerInfoProvider>(context);
    final cartController = Provider.of<Cart>(context, listen: false);

    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final bool isRep = customerController.customerInfo.customerRep != '';
    return Scaffold(
      backgroundColor: colorBgB,
      body: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          primary: false,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      !mobile(context)

                          ///WEBVIEW
                          ? Column(
                              children: [
                                Wrap(
                                    children: isRep
                                        ? [EngagementPanel(formKey: formKey)]
                                        : [
                                            EngagementPanel(formKey: formKey),
                                            const AddNotepad(),
                                          ]),
                                if (isRep)
                                  Container(
                                    color: const Color(0xFFDFEDFF),
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 2, 20, 20),
                                      child: EndPersonal(
                                        street: widget.street,
                                        city: widget.city,
                                        state: widget.state,
                                        zipcode: widget.zipcode,
                                      ),
                                    ),
                                  ),
                              ],
                            )

                          ///MOBILE VIEW
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (isRep)
                                    Container(
                                      color: const Color(0xFFDFEDFF),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 5, 10, 5),
                                        child: EndPersonal(
                                          street: widget.street,
                                          city: widget.city,
                                          state: widget.state,
                                          zipcode: widget.zipcode,
                                        ),
                                      ),
                                    ),
                                  Wrap(
                                      children: isRep
                                          ? [EngagementPanel(formKey: formKey)]
                                          : [
                                              EngagementPanel(formKey: formKey),
                                              const AddNotepad(),
                                            ]),
                                ],
                              ),
                            ),

                      //SAVE AND FINISH BUTTON
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GradientButtonWidget(
                            hideIcon: true,
                            function: () {
                              if (portabilityFormProvider.portabilityCheck) {
                                customerController.addPortabilityInfo(
                                    portabilityFormProvider.portFirstName,
                                    portabilityFormProvider.portLastName,
                                    portabilityFormProvider.portNumberStreet,
                                    portabilityFormProvider.portCity,
                                    portabilityFormProvider.portState,
                                    portabilityFormProvider.portZipcode,
                                    portabilityFormProvider.requestedPortDate,
                                    portabilityFormProvider
                                        .currentServiceProvider,
                                    portabilityFormProvider.telephoneNumber,
                                    portabilityFormProvider.billingTelephone);
                              }
                              if (portabilityFormProvider.fileSelected) {
                                portabilityFormProvider.uploadFileLastBill();
                              }
                            },
                            text: 'Save & Finish',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void finalPressed(CustomerInfoProvider customerController,
      Cart cartController) async {
    // if (customerController.orderSent) {
    // } else {
      if (formKey.currentState!.validate()) {
        // customerController.setColor(const Color(0xFF2E5899));
          // await customerController.createOrder(
          //   services: cartController.products,
          //   devices: cartController.devices,
          //   fees: cartController.fees,
          //   additionals: cartController.additionals,
          //   discounts: cartController.discounts,
          //   referral: portabilityr?.customerId,
          // );
          showDialog(
            barrierColor: const Color(0x00022963).withOpacity(0.40),
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return const FinalPopup();
            },
          );
      }
      // else {
      //   // customerController.setColor(const Color(0xFFD20030));
      // }
    // }
  }
}
