import 'package:badges/badges.dart' as badge;
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/bottom_cart_section_widget.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/selector_count_item_widget.dart';
import '../../../../providers/remote/boxes_behavior_controller.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final cartBehavior = Provider.of<BoxesBehavior>(context);
    final scrollController =  ScrollController();

    return cartBehavior.isCartVisible
        ? Visibility(
            visible: cartBehavior.isCartVisible,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1.5, color: colorBorder),
                  borderRadius: BorderRadius.circular(13.53),
                ),
              ),
              child: Consumer<Cart>(
                builder: (BuildContext context, Cart cart, Widget? child) {
                  final service = cartController.services.first;
                  return Column(children: <Widget>[

                    SelectorCountItemWidget(
                      title: service.name, 
                      description: service.description, 
                      subtotal: "${service.subtotal}", 
                      image: service.imageurl, 
                      counter: 1,
                      isRequired: true,
                      onRemove: () {
                        
                      },
                      onIncrementDecrement: (counter) {
                        
                      },
                    ),
                    Expanded(
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: <Widget>[
                                            
                            ColumnBuilder(
                              itemCount: cartController.merchantSelected.length,
                              itemBuilder: (BuildContext context, int index) {
                                final merchant = cartController.merchantSelected[index];
                        
                                return SelectorCountItemWidget(
                                  isRequired: false,
                                  title: merchant.name, 
                                  description: merchant.description, 
                                  subtotal: "${merchant.subtotal}", 
                                  image: merchant.imageurl, 
                                  counter: merchant.quantity,
                                  onRemove: () {
                                    cartController.removeFromCart(merchant.id);
                                  },
                                  onIncrementDecrement: (counter) {
                                    cartController.incrementDecrementQuantityCart(merchant.id, counter.toInt());
                                  },
                                );
                              },
                            ),
                                            
                          ],
                        )),
                      ),
                    ),

                    const BottomCartSectionWidget(),
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
