import 'package:badges/badges.dart' as badge;
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';
import '../../../../providers/remote/boxes_behavior_controller.dart';
import 'cart_buttons_views.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final cartBehavior = Provider.of<BoxesBehavior>(context);
    final scrollController = ScrollController();

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 950 ? true : false;

    return cartBehavior.isCartVisible
        ? Visibility(
            visible: cartBehavior.isCartVisible,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: cartWidth,
              height: MediaQuery.of(context).size.height * 0.5,
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
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25.0)),
                                              border: Border.all(
                                                color: colorSecondary,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const IconButton(
                                              iconSize: 20,
                                              padding:
                                                  EdgeInsets.all(1),
                                              constraints:
                                                  BoxConstraints(),
                                              icon: Icon(
                                                Icons.check,
                                                color: colorSecondary,
                                                size: 20,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                          Image.asset(
                                            'images/you-pointer.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                      title: Text(item.name,
                                          style: GoogleFonts.workSans(
                                              fontSize: 16,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.5)),
                                      subtitle: Text(item.category,
                                          style: GoogleFonts.workSans(
                                              fontSize: 13,
                                              color: colorInversePrimary,
                                              fontWeight: FontWeight.w400)),
                                      trailing: Text(
                                          '\$${item.cost} mo',
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
                            ],
                          )),
                    )),
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
                                '\$${cart.total}',
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
                            child:styledButton(context),
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
