import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/column_builder.dart';

//Los estilos están repetidos, separo ya que haya tiempo
class MiniCartTVMobile extends StatelessWidget {
  const MiniCartTVMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          )),
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
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -1.0)))),
            Expanded(
                child: SingleChildScrollView(
                    controller: ScrollController(),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text('Video Streams',
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
                                      fontSize: 15,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text('Recording Storage',
                                style: GoogleFonts.workSans(
                                    fontSize: 14,
                                    color: const Color(0xff3C7DCA),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.5)),
                          ),
                        ),

                        ColumnBuilder(
                          itemCount: cartController
                              .additionalsRecordingSelected.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = cartController
                                .additionalsRecordingSelected[index];
                            return ListTile(
                              title: Text(item.name,
                                  style: GoogleFonts.workSans(
                                      fontSize: 15,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text('Channel Packs',
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
                                      fontSize: 15,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text('Devices',
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
                            final item = cartController
                                .additionalsDevicesSelected[index];
                            return ListTile(
                              title: Text('${item.quantity} ${item.name}',
                                  style: GoogleFonts.workSans(
                                      fontSize: 15,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 0, 0, 0),
                            child: Text('Movies Bundles',
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
                                      fontSize: 15,
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
                    ))),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upgrade Subtotal',
                        style: GoogleFonts.workSans(
                            fontSize: 15,
                            color: const Color(0xff2e5899),
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5)),
                    Text(
                        "\$${cartController.additionalsTVPrice + cartController.totalDevices}",
                        style: GoogleFonts.workSans(
                            fontSize: 20,
                            color: const Color(0xff2e5899),
                            fontWeight: FontWeight.w300,
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
                    tvPopupController.restartIndexTVPopup();
                    tvPopupController.selectedOptions(0);
                    tvPopupController.selectedOptionsChannels(0);
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