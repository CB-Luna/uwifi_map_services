import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

// ignore: must_be_immutable
class SelectorCountItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String subtotal;
  final String image;
  final int counter;
  bool isRequired = false;
  final Function() onRemove;
  final Function(double) onIncrementDecrement;

  SelectorCountItemWidget(
    {
      Key? key, 
      required this.title, 
      required this.description, 
      required this.subtotal, 
      required this.image, 
      required this.counter,
      required this.isRequired,
      required this.onRemove,
      required this.onIncrementDecrement
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1024 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        decoration: ShapeDecoration(
          color: isRequired ? colorPrimary : colorBgWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.88),
          ),
          shadows: const [
            BoxShadow(
              color: colorBoxShadow,
              blurRadius: 3.97,
              offset: Offset(0, 0.99),
              spreadRadius: 0,
            )
          ],
        ),
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
            SizedBox(
              width: isMobile ? 90.0 : 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isRequired ? colorInversePrimary : colorBgBlack,
                      fontSize: isMobile ? 12.0 : 20.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isRequired ? colorInversePrimary : colorBgBlack,
                      fontSize: isMobile ? 10.0 : 12.0,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AbsorbPointer(
                    absorbing: isRequired,
                    child: CustomizableCounter(
                      minCount: 1,
                      count: counter.toDouble(),
                      onIncrement: onIncrementDecrement,
                      onDecrement: onIncrementDecrement,
                      incrementIcon: Icon(
                        Icons.add,
                        color: isRequired ? colorInversePrimary : colorBgBlack,
                      ),
                      decrementIcon: Icon(
                        Icons.remove,
                        color: isRequired ? colorInversePrimary : colorBgBlack,
                      ),
                      textColor: isRequired ? colorInversePrimary : colorBgBlack,
                      showButtonText: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Text(
                      '\$$subtotal',
                      style: TextStyle(
                        color: isRequired ? colorInversePrimary : colorBgBlack,
                        fontSize: isMobile ? 12.0 : 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !isRequired,
              child: InkWell(
                onTap: onRemove,
                child: Icon(
                  Icons.delete_outline,
                  color: isRequired ? colorInversePrimary : colorBgBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}