import 'package:badges/badges.dart' as badge;
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/customer_info_controller.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/popup_fees.dart';
import '../../../../providers/remote/boxes_behavior_controller.dart';
import '../../../../providers/steps_controller.dart';
import 'cart_buttons_views.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final plansController = Provider.of<PlanController>(context);

    final stepsController = Provider.of<StepsController>(context);
    final cartBehavior = Provider.of<BoxesBehavior>(context);
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final customerInfoProvider = Provider.of<CustomerInfoProvider>(context);
    final scrollController = ScrollController();

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 950 ? true : false;

    return cartBehavior.isCartVisible
        ? Visibility(
            visible: cartBehavior.isCartVisible,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: stepsController.currentStep == Views.finalSummaryView ||
                      stepsController.repCurrentStep ==
                          RepViews.finalSummaryView
                  ? (MediaQuery.of(context).size.width * 0.5) - 50
                  : cartWidth,
              margin: EdgeInsets.fromLTRB(mobile ? 25 : 0, 25, 25, 25),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: -5,
                  color: colorBgBlack,
                  offset: Offset(0, 15),
                )
              ], color: colorInversePrimary, borderRadius: BorderRadius.circular(50)),
              child: Consumer<Cart>(
                builder: (BuildContext context, Cart cart, Widget? child) {
                  return Column(children: <Widget>[
                    Container(
                        decoration: const BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClayContainer(
                              spread: 3,
                              color: colorInversePrimary,
                              parentColor: colorPrimary,
                              height: 35,
                              width: 35,
                              depth: 30,
                              borderRadius: 25,
                              curveType: CurveType.concave,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.keyboard_tab_rounded,
                                  color: colorPrimary,
                                  size: 18,
                                ),
                                onPressed: () {
                                  cartBehavior.changeCartVisibility();
                                },
                              ),
                            ),
                            Text("Your plan details",
                                style: h2Style(context,
                                    color: colorInversePrimary, fontSize: 18)),
                            const SizedBox(width: 30),
                          ],
                        )),
                    Expanded(
                        child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              const CartTab(title: "Service Plans"),

                              ColumnBuilder(
                                itemCount: cart.products.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (cart.products.isEmpty) {
                                    return const Text('no products in cart');
                                  }
                                  final item = cart.products[index];
                                  return ListTile(
                                      leading: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Visibility(
                                            visible: stepsController
                                                            .currentStep ==
                                                        Views
                                                            .finalSummaryView ||
                                                    stepsController
                                                            .repCurrentStep ==
                                                        RepViews
                                                            .finalSummaryView
                                                ? false
                                                : true,
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(25.0)),
                                                border: Border.all(
                                                  color:
                                                      const Color(0xFF8AA7D2),
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: IconButton(
                                                iconSize: 20,
                                                padding:
                                                    const EdgeInsets.all(1),
                                                constraints:
                                                    const BoxConstraints(),
                                                icon: const Icon(
                                                  Icons.cancel,
                                                  color: Color(0xff8aa7d2),
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  cartController
                                                      .removeFromCart(item);
                                                  if (!plansController
                                                      .isAnyPlanActive()) {
                                                    if (!(plansController
                                                            .networkType
                                                            .toLowerCase()
                                                            .contains(
                                                                "fiber") &&
                                                        plansController
                                                            .locationGroup
                                                            .toString()
                                                            .toUpperCase()
                                                            .contains("SMI"))) {
                                                      cartController
                                                          .discountRules();
                                                    }
                                                  }

                                                  if (item.category.contains(
                                                          'Internet') ||
                                                      item.category
                                                          .contains('bundle')) {
                                                    plansController
                                                        .plansActivation(
                                                            [], true);
                                                    plansController
                                                        .plansActivation([
                                                      "gigFastInternet",
                                                      "bundleService"
                                                    ], false);
                                                    cartController
                                                        .clearAllProducts();
                                                    plansController
                                                        .unselectAll();

                                                    stepsController
                                                            .currentStep =
                                                        Views.plansView;
                                                  }
                                                  if (item.category
                                                      .contains('TV')) {
                                                    cartController
                                                        .clearProductsGigFastTV();
                                                  }
                                                  if (item.category
                                                      .contains('Voice')) {
                                                    cartController
                                                        .clearProductsGigFastVoice();
                                                    portabilityFormProvider
                                                        .clearInformationPortability();
                                                    portabilityFormProvider
                                                            .portabilityCheck =
                                                        false;
                                                  }

                                                  plansController.plansList
                                                      .firstWhere((element) =>
                                                          element.name ==
                                                          item.name)
                                                      .isSelected = false;
                                                },
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            'images/you-pointer.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                      title: Text("Package ${index + 1}",
                                          style: GoogleFonts.workSans(
                                              fontSize: 16,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.5)),
                                      subtitle: Text("$index",
                                          style: GoogleFonts.workSans(
                                              fontSize: 13,
                                              color: colorInversePrimary,
                                              fontWeight: FontWeight.w400)),
                                      trailing: Text(
                                          '\$ 30/mo',
                                          style: GoogleFonts.workSans(
                                              fontSize: 18,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: -1.0)));
                                },
                              ),

                              const CartTab(title: "Devices"),

                              ColumnBuilder(
                                itemCount:
                                    cart.additionalsDevicesSelected.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      cart.additionalsDevicesSelected[index];
                                  return ListTile(
                                    leading: 
                                    Image.asset(
                                        'images/you-pointer.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                    title: Text('Package $index',
                                        style: GoogleFonts.workSans(
                                            fontSize: 16,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5)),
                                    trailing: Text(
                                        '\$ 30/mo',
                                        style: GoogleFonts.workSans(
                                            fontSize: 18,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -1.0)),
                                  );
                                },
                              ),

                              const CartTab(title: "Additionals"),

                              ColumnBuilder(
                                itemCount: cart.additionals.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item = cart.additionals[index];
                                  return ListTile(
                                    title: Text(
                                        item.name.contains('Bundle') ||
                                                item.quantity < 1
                                            ? item.name
                                            : ('${item.name} +${item.quantity} '),
                                        style: GoogleFonts.workSans(
                                            fontSize: 16,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5)),
                                    trailing: Text(
                                        '\$ 30/mo',
                                        style: GoogleFonts.workSans(
                                            fontSize: 18,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -1.0)),
                                  );
                                },
                              ),

                              const CartTab(title: "Discounts"),

                              ColumnBuilder(
                                itemCount: cart.discounts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (cart.discounts.isEmpty) {
                                    return const Text('');
                                  }
                                  final item = cart.discounts[index];
                                  return ListTile(
                                    title: Text(item.name,
                                        style: GoogleFonts.workSans(
                                            fontSize: 16,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5)),
                                    trailing: Text(
                                        '\$ 30 /mo',
                                        style: GoogleFonts.workSans(
                                            fontSize: 18,
                                            color: colorPrimary,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -1.0)),
                                    // onTap: () {
                                    //   context.read<Cart>().removeFromCart(item);
                                    // },
                                  );
                                },
                              ),

                              // CartTab(
                              //     title: "Fees",
                              //     widget: TextButton(
                              //         onPressed: () {
                              //           // showDialog(
                              //           //   barrierColor: const Color(0x00022963)
                              //           //       .withOpacity(0.40),
                              //           //   context: context,
                              //           //   builder: (_) {
                              //           //     return const FeesPopup();
                              //           //   },
                              //           // );
                              //         },
                              //         child: Text(
                              //           'What is this?',
                              //           style: bodyStyle(context, fontSize: 12),
                              //         ))),

                              // ColumnBuilder(
                              //   itemCount: cart.fees.length,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     if (cart.fees.isEmpty) {
                              //       return const Text('no fees in cart');
                              //     }
                              //     final item = cart.fees[index];
                              //     return ListTile(
                              //       title: Text(item.name,
                              //           style: GoogleFonts.workSans(
                              //               fontSize: 16,
                              //               color: colorPrimary,
                              //               fontWeight: FontWeight.w700,
                              //               letterSpacing: -0.5)),
                              //       trailing: Text(
                              //           '\$ ${item.cost.toString()} /mo',
                              //           style: GoogleFonts.workSans(
                              //               fontSize: 18,
                              //               color: colorPrimary,
                              //               fontWeight: FontWeight.w300,
                              //               letterSpacing: -1.0)),
                              //       // onTap: () {
                              //       //   context.read<Cart>().removeFromCart(item);
                              //       // },
                              //     );
                              //   },
                              // ),

                              //const Divider(),
                            ],
                          )),
                    )),
                    // Visibility(
                    //   visible:
                    //       stepsController.currentStep == Views.finalSummaryView
                    //           ? false
                    //           : true,
                    //   child: Column(
                    //     children: [
                    //       const Divider(),
                    //       Padding(
                    //         padding: const EdgeInsets.all(10.0),
                    //         child: Container(
                    //           height: 40,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(50),
                    //             shape: BoxShape.rectangle,
                    //             border: Border.all(
                    //               color: const Color(0xFFD8E3F2),
                    //             ),
                    //           ),
                    //           child: Row(
                    //             mainAxisSize: MainAxisSize.max,
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Expanded(
                    //                 child: Padding(
                    //                   padding:
                    //                       const EdgeInsetsDirectional.fromSTEB(
                    //                           5, 5, 5, 5),
                    //                   child: TextFormField(
                    //                     //controller: textController,
                    //                     obscureText: false,
                    //                     decoration: InputDecoration(
                    //                       isDense: true,
                    //                       hintText: customerInfoProvider
                    //                                   .promos.length ==
                    //                               1
                    //                           ? ((customerInfoProvider.promos
                    //                                   .contains("SM"))
                    //                               ? 'Add here a promo code'
                    //                               : customerInfoProvider
                    //                                   .promos[0])
                    //                           : 'Add here a promo code',
                    //                       hintStyle: const TextStyle(
                    //                         fontFamily: 'Work Sans',
                    //                         color: Color(0xFF8AA7D2),
                    //                         fontSize: 13,
                    //                       ),
                    //                       enabledBorder: InputBorder.none,
                    //                       focusedBorder: InputBorder.none,
                    //                     ),
                    //                     style: const TextStyle(
                    //                       fontFamily: 'Work Sans',
                    //                       color: Color(0xFF8AA7D2),
                    //                       fontSize: 13,
                    //                     ),
                    //                     textAlign: TextAlign.start,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding:
                    //                     const EdgeInsetsDirectional.fromSTEB(
                    //                         5, 5, 5, 5),
                    //                 child: ElevatedButton(
                    //                   onPressed: () {},
                    //                   style: ElevatedButton.styleFrom(
                    //                     shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.circular(50.0),
                    //                     ),
                    //                     backgroundColor:
                    //                         const Color(0xFFD20030),
                    //                     side: const BorderSide(
                    //                       color: Colors.transparent,
                    //                       width: 1,
                    //                     ),
                    //                   ),
                    //                   child: Text('Apply',
                    //                       style: GoogleFonts.workSans(
                    //                           height: 1.5,
                    //                           fontSize: 14,
                    //                           color: colorInversePrimary,
                    //                           fontWeight: FontWeight.w600,
                    //                           letterSpacing: -0.2)),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, bottom: 15.0, left: 20.0, right: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal',
                                style: GoogleFonts.workSans(
                                    fontSize: 16,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5)),
                            Text(
                                '\$30.0',
                                style: GoogleFonts.workSans(
                                    fontSize: 30,
                                    color: colorPrimary,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -0.5)),
                            //style: Theme.of(context).textTheme.headline3
                          ]),
                    ),
                    Visibility(
                      visible: !mobile,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child:
                                customerInfoProvider.customerInfo.customerRep !=
                                        ""
                                    ? styledRepButton(context)
                                    : styledButton(context),
                          )
                        ],
                      ),
                    )
                  ]);
                },
              ),
            ),
          )
        : Visibility(
            visible: !cartBehavior.isCartVisible,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClayContainer(
                spread: 6,
                color: colorPrimary,
                parentColor: colorBgBlack,
                height: 45,
                width: 45,
                depth: 40,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: GestureDetector(
                  onTap: () {
                    cartBehavior.changeCartVisibility();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: badge.Badge(
                      badgeContent: Text(
                          cartController.generalCartCounter.toString(),
                          style: const TextStyle(color: colorInversePrimary)),
                      showBadge:
                          cartController.generalCartCounter == 0 ? false : true,
                      badgeColor: colorPrimary,
                      position: badge.BadgePosition.bottomStart(),
                      elevation: 4,
                      child: const Icon(
                        Icons.add_shopping_cart,
                        color: colorInversePrimary,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // IconButton(
            //   splashRadius: 15.0,
            //   padding: const EdgeInsets.all(12.0),
            //   icon: const Icon(
            //     Icons.shopping_cart,
            //     color: Color.fromARGB(255, 10, 56, 126),
            //     size: 30,
            //   ),
            //   onPressed: () {
            //     cartController.changeVisibility();
            //   },
            // ),
          );
  }
}

class CartTab extends StatelessWidget {
  const CartTab({
    Key? key,
    required this.title,
    this.widget,
  }) : super(key: key);

  final String title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    Color color = colorsTheme(context).onSurface;
    return Container(
      alignment: Alignment.centerLeft,
      height: 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color.withOpacity(0), color.withOpacity(0.25)]),
          border: Border(bottom: BorderSide(color: color, width: 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: tagTitleStyle(context, color: color)),
            if (widget != null) widget!
          ],
        ),
      ),
    );
  }
}
