import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';

//Los estilos están repetidos, separo ya que haya tiempo
class MiniCartTV extends StatelessWidget {
  const MiniCartTV({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool tablet = size.width < 1350 ? true : false;
    final scrollController = ScrollController();
    return Container(
      margin: tablet
          ? const EdgeInsets.all(0)
          : const EdgeInsets.fromLTRB(0, 15, 0, 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              bottomLeft: Radius.circular(50.0))),
      width: 250,
      height: 400,
      child: Consumer<Cart>(
        builder: (BuildContext context, Cart cartController, Widget? child) {
          return Column(children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF2e5899),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50.0))),
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text("Your upgrade details",
                        style: GoogleFonts.workSans(
                            fontSize: tablet ? 10 : 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -1.0)))),
            Expanded(
                child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: <Widget>[
                     

                  
                      

                      Container(
                        alignment: Alignment.centerLeft,
                        height: 20,
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFEDFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                              'Devices ${cartController.additionalsDevicesSelected.isEmpty ? "" : cartController.additionalsDevicesSelected.length}',
                              style: GoogleFonts.workSans(
                                  fontSize: 14,
                                  color: const Color(0xff3C7DCA),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                      ),

                      ColumnBuilder(
                        itemCount:
                            cartController.additionalsDevicesSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              cartController.additionalsDevicesSelected[index];
                          return ListTile(
                            title: Text('${item.quantity} ${item.name}',
                                style: GoogleFonts.workSans(
                                    fontSize: tablet ? 10 : 16,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5)),
                            trailing: Text(
                                '\$ ${(item.cost * item.quantity)}/mo',
                                style: GoogleFonts.workSans(
                                    fontSize: 18,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -1.0)),
                          );
                        },
                      ),


                      //const Divider(),
                    ],
                  )),
            )),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upgrade Subtotal',
                        style: GoogleFonts.workSans(
                            fontSize: tablet ? 10 : 16,
                            color: const Color(0xff2e5899),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5)),
                    //style: Theme.of(context).textTheme.headline3
                  ]),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Opacity(
                opacity: 1.0,
                // cartController.products.isNotEmpty ? 1.0 : 0.50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color(0xFFd20030),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    // if (cartController.products.isNotEmpty)
                    //   {print("tas lleno")}
                    Navigator.of(context).pop();
                  },
                  child: Text('Accept',
                      style: GoogleFonts.workSans(
                          height: 1.5,
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2)),
                ),
              ),
            )
          ]);
        },
      ),
    );
  }
}
