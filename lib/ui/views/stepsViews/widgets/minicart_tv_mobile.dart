import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';

//Los estilos están repetidos, separo ya que haya tiempo
class MiniCartTVMobile extends StatelessWidget {
  const MiniCartTVMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      width: sizeWidth * 0.75,
      height: 500,
      child: Consumer<Cart>(
        builder: (BuildContext context, Cart cartController, Widget? child) {
          return Column(children: <Widget>[
            Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF2e5899),
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Text("Your upgrade details",
                        style: GoogleFonts.workSans(
                            fontSize: 14,
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
                              'Video Streams ${cartController.additionalsVideoSelected.isEmpty ? "" : cartController.additionalsVideoSelected.length}',
                              style: GoogleFonts.workSans(
                                  fontSize: 14,
                                  color: const Color(0xff3C7DCA),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                      ),

                      ColumnBuilder(
                        itemCount:
                            cartController.additionalsVideoSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              cartController.additionalsVideoSelected[index];
                          return ListTile(
                            title: Text(item.name,
                                style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5)),
                            trailing: Text('\$ ${item.cost.toString()}/mo',
                                style: GoogleFonts.workSans(
                                    fontSize: 18,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -1.0)),
                          );
                        },
                      ),

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
                              'Recording Storage ${cartController.additionalsRecordingSelected.isEmpty ? "" : cartController.additionalsRecordingSelected.length}',
                              style: GoogleFonts.workSans(
                                  fontSize: 14,
                                  color: const Color(0xff3C7DCA),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                      ),

                      ColumnBuilder(
                        itemCount:
                            cartController.additionalsRecordingSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = cartController
                              .additionalsRecordingSelected[index];
                          return ListTile(
                            title: Text(item.name,
                                style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5)),
                            trailing: Text('\$ ${item.cost.toString()}/mo',
                                style: GoogleFonts.workSans(
                                    fontSize: 18,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -1.0)),
                          );
                        },
                      ),

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
                              'Channel Packs ${cartController.packsPremiumSelected.isEmpty ? "" : cartController.packsPremiumSelected.length}',
                              style: GoogleFonts.workSans(
                                  fontSize: 14,
                                  color: const Color(0xff3C7DCA),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                      ),

                      ColumnBuilder(
                        itemCount: cartController.packsPremiumSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              cartController.packsPremiumSelected[index];
                          return ListTile(
                            title: Text(item.name,
                                style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5)),
                            trailing: Text('\$ ${item.cost.toString()}/mo',
                                style: GoogleFonts.workSans(
                                    fontSize: 18,
                                    color: const Color(0xff2e5899),
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -1.0)),
                          );
                        },
                      ),

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
                                    fontSize: 14,
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
                              'Movies Bundles ${cartController.moviesBundleSelected.isEmpty ? "" : cartController.moviesBundleSelected.length}',
                              style: GoogleFonts.workSans(
                                  fontSize: 14,
                                  color: const Color(0xff3C7DCA),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5)),
                        ),
                      ),

                      ColumnBuilder(
                        itemCount: cartController.moviesBundleSelected.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                              cartController.moviesBundleSelected[index];
                          return ListTile(
                            title: Text(item.name,
                                style: GoogleFonts.workSans(
                                    fontSize: 14,
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
                            fontSize: 16,
                            color: const Color(0xff2e5899),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5)),
                    Text(
                        "\$${cartController.additionalsTVPrice + cartController.totalDevices}",
                        style: GoogleFonts.workSans(
                            fontSize: 26,
                            color: const Color(0xff2e5899),
                            fontWeight: FontWeight.w300,
                            letterSpacing: -0.5)),
                    //style: Theme.of(context).textTheme.headline3
                  ]),
            ),
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
