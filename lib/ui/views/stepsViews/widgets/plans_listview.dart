import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/bundle_custom_radio_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/plans_custom_radio_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/internet_popup/internet_popup.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/voice_popup.dart';

import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';

import '../../../../data/constants.dart';
import '../../../../providers/customer_info_controller.dart';
import '../../../../providers/remote/boxes_behavior_controller.dart';

class PlansListView extends StatelessWidget {
  final String category;

  const PlansListView({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plansController = Provider.of<PlanController>(context);
    final customerController = Provider.of<CustomerInfoProvider>(context);
    final cartController = Provider.of<Cart>(context);
    final boxesController = Provider.of<BoxesBehavior>(context);

    final products = plansController.plansList
        .where((plan) => plan.planCategory == category)
        .toList();
    products.sort((a, b) => b.price!.compareTo(a.price!));

    final double screenSpace =
        boxesController.isCartVisible && boxesController.isPromosListVisible
            ? screenSize(context).width - 570
            : screenSize(context).width - 100;

    final cardWidth = lerpDouble(160, screenSpace / 3.5, equiv(context));

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: screenSize(context).width > 1450 ? 15.0 : 5),
      width: cardWidth,
      child: Column(
        children: [
          category.contains('bundle')
              ? Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Text("Bundles",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: mobile(context) ? 16 : 20,
                        color: const Color(0xFF2e5899),
                        fontWeight: FontWeight.w700,
                      )))
              : Image.asset(
                  'images/uwifi.png',
                  height: 40,
                ),
          Flexible(
            child: ListView.builder(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (_, int index) {
                Product product = Product(
                  id: products[index].id,
                  name: products[index].name!,
                  cost: products[index].price!,
                  imageurl: category.contains('bundle')
                      ? '../assets/images/swipes.png'
                      : '../assets/images/icon_$category.png',
                  service: '',
                  category: products[index].planCategory,
                  quantity: 1,
                  pwName: products[index].pwName ?? '',
                );

                return GestureDetector(
                    onTap: () {
                      if (products[index].isEnabled) {
                        if (!products[index].planCategory.contains('bundle')) {
                          openPopup(
                            context,
                            category,
                            products[index],
                            plansController.customerType,
                          );
                        }

                        if (!products[index].isSelected) {

                          //Se selecciona el plan específico
                          plansController.selectPlan(products[index]);

                          //P A T H :  C U S T O M E R   C A R E   R E P

                          //Si el usuario es un customer care Rep, todos los planes se encuentran activos
                          //Es decir, no aplican las reglas del negocio de habilitar o no los planes de acuerdo al
                          //Nivel del plan seleccionado de internet

                          if (customerController.customerInfo.customerRep !=
                              "") {
                            plansController.plansActivation([], true);

                            if (plansController.promosList.isNotEmpty) {
                              if (plansController
                                  .findPlanWActivePromo(products[index])) {
                                //Se agrega al carrito la promoción, sólo si esta se encuentra activa,
                                //agregando la promoción del plan actual que concuerde dentro de la lista de
                                //promos, y que además este se encuentre activo (isActive ==true)
                              }
                            }
                          }

                          if (products[index].planCategory.contains("bundle")) {
                            plansController.plansActivation(
                                [products[index].planCategory], false);
                          } else if (products[index]
                              .planCategory
                              .contains('gig')) {
                            {
                              plansController.plansActivation([], false);
                              plansController
                                  .plansActivation(['bundleService'], true);
                            }
                          } else {
                            // P A T H :  F L U J O   R E G L A S   B A S E

                            //Si el plan de internet seleccionado es el de menor precio,
                            //se inhabilita la selección del plan más alto de TV

                            if (plansController.getLowestIntPlan().isSelected) {
                              if (plansController
                                  .getHighestTVPlan()
                                  .isSelected) {
                                cartController.clearProductsGigFastTV();
                              }

                              plansController.plansActivation([], true);
                              plansController.lowestPlanActivation();

                              cartController.products.removeWhere((product) =>
                                  product.name ==
                                  plansController.getHighestTVPlan().name);
                            } else {
                              plansController.plansActivation([], true);
                            }
                          }

                          cartController.validateAddProduct(product);

                          //Se verifica los descuentos de acuerdo al total de productos
                          //Se verifica que no apliquen los decuentos de bundle en caso de pertenecer al área de SMI y tener tecnología de Fibra
                          if (!plansController.isAnyPlanActive()) {
                            if (!(plansController.networkType
                                    .toLowerCase()
                                    .contains("fiber") &&
                                plansController.locationGroup
                                    .toString()
                                    .toUpperCase()
                                    .contains("SMI"))) {
                            }
                          } else {
                          }
                        }
                      }
                    },
                    child: MouseRegion(
                        cursor: products[index].isEnabled
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.forbidden,
                        child: (products[index].planCategory.contains('bundle')
                            ? BundleCustomRadio(plan: products[index])
                            : products[index].associations == null
                                ? PlansCustomRadio(
                                    plan: products[index], isTherePromo: false)
                                : (customerController
                                            .customerInfo.customerRep !=
                                        "")
                                    ? (plansController.findPlanWActivePromo(
                                            products[index]))
                                        ? planCustomRadioPromo(
                                            products[index], context)
                                        : PlansCustomRadio(
                                            plan: products[index],
                                            isTherePromo: true)
                                    : customerController.promos.isNotEmpty
                                        ? activeCustomerPromo(products[index],
                                                customerController)
                                            ? activateCustomerPromo(
                                                products[index], context)
                                            // PlansCustomRadio(
                                            //     plan: products[index],
                                            //     isTherePromo: true)
                                            : PlansCustomRadio(
                                                plan: products[index],
                                                isTherePromo: false)
                                        : PlansCustomRadio(
                                            plan: products[index],
                                            isTherePromo: false))));
              },
            ),
          ),
        ],
      ),
    );
  }

  void openPopup(
    context,
    String category,
    Plan currentPlan,
    String customerType,
  ) {
    showDialog(
      barrierColor: const Color(0x00022963).withOpacity(0.40),
      context: context,
      builder: (_) {
        final customerController = Provider.of<CustomerInfoProvider>(context);

        switch (category) {
          case "gigFastTV":
            return TVPopup(plan: currentPlan);

          case "gigFastInternet":
            return InternetPopup(
                plan: currentPlan,
                customerRep: customerController.customerInfo.customerRep!);

          case "gigFastVoice":
            return VoicePopup(plan: currentPlan, customerType: customerType);

          default:
            return InternetPopup(
                plan: currentPlan,
                customerRep: customerController.customerInfo.customerRep!);
        }
      },
    );
  }

  Widget planCustomRadioPromo(plan, context) {
    Products promo = getPromo(context, plan);

    Widget planBox = PlansCustomRadio(
        plan: plan, isTherePromo: true, promo: promo, isPromoApplied: true);

    if (plan.isSelected) {
      // cartController.products.clear();
    }

    return planBox;
  }

  Products getPromo(context, plan) {
    final plansController = Provider.of<PlanController>(context, listen: false);

    Products promo = Products();

    var activePromos = plansController.promosList
        .where((promotion) => promotion.isActive == true)
        .map((promo) => promo.id);

    for (Products planPromotion in plan.associations!.pack!.products) {
      if (activePromos.contains(planPromotion.id)) {
        promo = planPromotion;
      }
    }

    return promo;
  }

  activateCustomerPromo(plan, context) {
    final customerController = Provider.of<CustomerInfoProvider>(context);

    //Check Promos
    if (plan.isSelected) {
      if (plan.associations != null) {
        if (customerController.promos.isNotEmpty) {
          for (var i = 0; i < plan.associations!.pack!.products!.length; i++) {
            if (customerController.promos
                .contains(plan.associations!.pack!.products![i].id)) {
            }
          }
        }
      }
    }

    return PlansCustomRadio(plan: plan, isTherePromo: true);
  }

  bool activeCustomerPromo(product, customerController) {
    bool activePromo = false;
    for (var i = 0; i < product.associations!.pack!.products!.length; i++) {
      if (customerController.promos
          .contains(product.associations!.pack!.products![i].id)) {
        activePromo = true;
      }
    }

    return activePromo;
  }
}
