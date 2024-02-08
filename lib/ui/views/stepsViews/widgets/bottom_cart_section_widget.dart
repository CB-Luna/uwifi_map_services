import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/cart_buttons_views.dart';

class BottomCartSectionWidget extends StatelessWidget {
  const BottomCartSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: isMobile ? 155.0 : 200.0,
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  RowSummaryWidget(
                    firstString: "Subtotal",
                    secondString: "\$${cartController.total}",
                    thirdString: "Items (${cartController.generalCartCounter})",
                    size: 12,
                  ),
                   const RowSummaryWidget(
                    firstString: "Taxes",
                    secondString: "\$0.00",
                    thirdString: "",
                    size: 14,
                  ),
                   const RowSummaryWidget(
                    firstString: "Shipping Cost",
                    secondString: "\$0.00",
                    thirdString: "",
                    size: 12,
                  ),
                  Visibility(
                    visible: !isMobile,
                    child: SizedBox (
                      width: 150,
                      child: styledButton(context)),
                  ),
                ],
              ),
            ),
            Row(
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'SECURE PAYMENTS PROVIDED BY',
                style: TextStyle(
                  color: colorBorder,
                  fontSize: 9.57,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogosPaymentsWidget(
                  isLastOne: false,
                  source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/mastercard.png?t=2024-01-09T03%3A45%3A54.326Z",
                  width: 30.0,
                  height: 15.0,
                ),
                LogosPaymentsWidget(
                  isLastOne: false,
                  source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/visa.png",
                  width: 30.0,
                  height: 15.0,
                ),
                LogosPaymentsWidget(
                  isLastOne: false,
                  source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/visa.png",
                  width: 30.0,
                  height: 15.0,
                ),
              ],
            )
          ],
        )
        :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: isMobile ? 80 : 130,
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
                        width: isMobile ? 130 : 150,
                        height: 30,
                        child: const CustomOutlinedButton(
                          text: "Apply Coupon",
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'SECURE PAYMENTS PROVIDED BY',
                    style: TextStyle(
                      color: colorBorder,
                      fontSize: 9.57,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w600,
                      height: 0.16,
                      letterSpacing: 0.80,
                    ),
                  ),
                  const Row(
                    children: [
                      LogosPaymentsWidget(
                        isLastOne: false,
                        source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/mastercard.png?t=2024-01-09T03%3A45%3A54.326Z",
                        width: 45.0,
                        height: 25.0,
                      ),
                      LogosPaymentsWidget(
                        isLastOne: false,
                        source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/visa.png",
                        width: 45.0,
                        height: 25.0,
                      ),
                      LogosPaymentsWidget(
                        isLastOne: false,
                        source: "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/visa.png",
                        width: 45.0,
                        height: 25.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowSummaryWidget(
                    firstString: "Subtotal",
                    secondString: "\$${cartController.total}",
                    thirdString: "Items (${cartController.generalCartCounter})",
                    size: 12,
                  ),
                   const RowSummaryWidget(
                    firstString: "Taxes",
                    secondString: "\$0.00",
                    thirdString: "",
                    size: 16,
                  ),
                   const RowSummaryWidget(
                    firstString: "Shipping Cost",
                    secondString: "\$0.00",
                    thirdString: "",
                    size: 12,
                  ),
                  Visibility(
                    visible: !isMobile,
                    child: SizedBox (
                      width: 150,
                      child: styledButton(context)),
                  ),
                ],
              ),
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

  const RowSummaryWidget({
    super.key, 
    required this.firstString, 
    required this.secondString, 
    required this.thirdString,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstString,
          style: TextStyle(
            color: colorInversePrimary,
            fontSize: size,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 5,),
        Text(
          secondString,
          style: TextStyle(
            color: colorInversePrimary,
            fontSize: size,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 5,),
        Text(
          thirdString,
          style: TextStyle(
            color: colorInversePrimary,
            fontSize: size,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w200,
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