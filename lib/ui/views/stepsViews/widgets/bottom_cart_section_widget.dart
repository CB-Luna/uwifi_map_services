import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart_buttons_views.dart';

class BottomCartSectionWidget extends StatelessWidget {

  final String title;
  final String description;
  final String subtotal;
  final String image;
  final int counter;
  final Function() onRemove;
  final Function(double) onIncrementDecrement;

  const BottomCartSectionWidget({
    super.key,
    required this.title, 
    required this.description, 
    required this.subtotal, 
    required this.image, 
    required this.counter,
    required this.onRemove,
    required this.onIncrementDecrement
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-1.00, -0.04),
            end: Alignment(1, 0.04),
            colors: [colorPrimaryLight, colorPrimaryDark],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isMobile ?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: isMobile ? 55.0 : 80.0,
                      height: isMobile ? 55.0 : 80.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      width: isMobile ? 100.0 : 200.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: colorInversePrimary,
                              fontSize: isMobile ? 12.0 : 20.0,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colorInversePrimary,
                              fontSize: isMobile ? 10.0 : 12.0,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AbsorbPointer(
                          absorbing: true,
                          child: CustomizableCounter(
                            borderColor: Colors.transparent,
                            minCount: 1,
                            count: counter.toDouble(),
                            onIncrement: onIncrementDecrement,
                            onDecrement: onIncrementDecrement,
                            incrementIcon: const Icon(
                              Icons.add,
                              color: colorInversePrimary,
                            ),
                            decrementIcon: const Icon(
                              Icons.remove,
                              color: colorInversePrimary,
                            ),
                            textColor: colorInversePrimary,
                            showButtonText: false,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                          child: Text(
                            '\$$subtotal',
                            style: TextStyle(
                              color: colorInversePrimary,
                              fontSize: isMobile ? 12.0 : 16.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            RowSummaryWidget(
              firstString: "Subtotal",
              secondString: "\$${cartController.total}",
              thirdString: "Items (${cartController.generalCartCounter})",
              size: 12,
              firstWidth: MediaQuery.of(context).size.width * 0.25,
              secondWidth: MediaQuery.of(context).size.width * 0.20,
              thirdWidth: MediaQuery.of(context).size.width * 0.10,
            ),
            RowSummaryWidget(
              firstString: "Taxes",
              secondString: "\$0.00",
              thirdString: "",
              size: 14,
              firstWidth: MediaQuery.of(context).size.width * 0.25,
              secondWidth: MediaQuery.of(context).size.width * 0.20,
              thirdWidth: MediaQuery.of(context).size.width * 0.10,
            ),
            RowSummaryWidget(
              firstString: "Shipping Cost",
              secondString: "\$0.00",
              thirdString: "",
              size: 12,
              firstWidth: MediaQuery.of(context).size.width * 0.25,
              secondWidth: MediaQuery.of(context).size.width * 0.20,
              thirdWidth: MediaQuery.of(context).size.width * 0.10, 
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: isMobile ? 120 : 130,
                    height: 35,
                    child: TextFormField(
                      cursorColor: colorBorder,
                        decoration: InputDecoration(
                          labelText: 'Coupon Code',
                          labelStyle: const TextStyle(
                              color: colorBorder,
                              fontSize: 14,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: colorBgWhite
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: colorBgWhite
                            ),
                          ),
                          filled: true,
                          fillColor: colorBgWhite,
                        ),
                        style: const TextStyle(
                          color: colorBorder,
                          fontSize: 14,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                SizedBox(
                    width: isMobile ? 130 : 150,
                    height: 30,
                    child: const CustomOutlinedButton(
                      text: "Apply Coupon",
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        :
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: isMobile ? 55.0 : 80.0,
                            height: isMobile ? 55.0 : 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            width: isMobile ? 120.0 : 200.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    color: colorInversePrimary,
                                    fontSize: isMobile ? 12.0 : 20.0,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: colorInversePrimary,
                                    fontSize: isMobile ? 10.0 : 12.0,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AbsorbPointer(
                                absorbing: true,
                                child: CustomizableCounter(
                                  borderColor: Colors.transparent,
                                  minCount: 1,
                                  count: counter.toDouble(),
                                  onIncrement: onIncrementDecrement,
                                  onDecrement: onIncrementDecrement,
                                  incrementIcon: const Icon(
                                    Icons.add,
                                    color: colorInversePrimary,
                                  ),
                                  decrementIcon: const Icon(
                                    Icons.remove,
                                    color: colorInversePrimary,
                                  ),
                                  textColor: colorInversePrimary,
                                  showButtonText: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                child: Text(
                                  '\$$subtotal',
                                  style: TextStyle(
                                    color: colorInversePrimary,
                                    fontSize: isMobile ? 12.0 : 16.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      RowSummaryWidget(
                        firstString: "Subtotal",
                        secondString: "\$${cartController.total}",
                        thirdString: "Items (${cartController.generalCartCounter})",
                        size: isMobile ? 12 : 15,
                        firstWidth: MediaQuery.of(context).size.width * 0.1,
                        secondWidth: MediaQuery.of(context).size.width * 0.05,
                        thirdWidth: MediaQuery.of(context).size.width * 0.04,
                      ),
                       RowSummaryWidget(
                        firstString: "Taxes",
                        secondString: "\$0.00",
                        thirdString: "",
                        size: isMobile ? 12 : 15,
                        firstWidth: MediaQuery.of(context).size.width * 0.1,
                        secondWidth: MediaQuery.of(context).size.width * 0.05,
                        thirdWidth: MediaQuery.of(context).size.width * 0.04,
                      ),
                       RowSummaryWidget(
                        firstString: "Shipping Cost",
                        secondString: "\$0.00",
                        thirdString: "",
                        size: isMobile ? 12 : 15,
                        firstWidth: MediaQuery.of(context).size.width * 0.1,
                        secondWidth: MediaQuery.of(context).size.width * 0.05,
                        thirdWidth: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                            height: 35,
                            child: TextFormField(
                              cursorColor: colorBorder,
                                // validator: (value) {
                                // },
                                decoration: InputDecoration(
                                  labelText: 'Coupon Code',
                                  labelStyle: const TextStyle(
                                      color: colorBorder,
                                      fontSize: 14,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: colorBgWhite
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: colorBgWhite
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: colorBgWhite,
                                ),
                                style: const TextStyle(
                                  color: colorBorder,
                                  fontSize: 14,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: 30,
                            child: const CustomOutlinedButton(
                              text: "Apply Coupon",
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox (
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 50,
                          child: styledButton(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowSummaryWidget extends StatelessWidget {
  final String firstString;
  final String secondString;
  final String thirdString;
  final double size;
  final double firstWidth;
  final double secondWidth;
  final double thirdWidth;

  const RowSummaryWidget({
    super.key, 
    required this.firstString, 
    required this.secondString, 
    required this.thirdString,
    required this.size, 
    required this.firstWidth,
    required this.secondWidth,
    required this.thirdWidth
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: firstWidth,
          child: Text(
            firstString,
            style: TextStyle(
              color: colorInversePrimary,
              fontSize: size * 1.1,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: secondWidth,
          child: Text(
            secondString,
            style: TextStyle(
              color: colorInversePrimary,
              fontSize: size * 1.3,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: thirdWidth,
          child: Text(
            thirdString,
            style: TextStyle(
              color: colorInversePrimary,
              fontSize: size * 0.8,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w200,
            ),
          ),
        )
      ],
    );
  }
}

class LogosPaymentsWidget extends StatelessWidget {
  final String source;
  final bool isLastOne;
  final double width;
  final double height;

  const LogosPaymentsWidget({
    super.key, 
    required this.source, 
    required this.isLastOne,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: colorBgWhite,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.80, color: colorBorder),
              borderRadius: BorderRadius.circular(4.78),
            ),
          ),
          child: Center(
            child: Image.network(
              source,
              fit: BoxFit.fill,
            ),
          ),
        ),
        isLastOne ? 
        const SizedBox()
        :
        const SizedBox(width: 5,)
      ],
    );
  }
}