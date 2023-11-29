import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:uwifi_map_services/icons/my_flutter_app_icons.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/channel_tabs_mobile.dart';

class CircularTapsMenu extends StatelessWidget {
  final String idTV;
  const CircularTapsMenu({Key? key, required this.idTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final bool tablet = 800 < size.width  ? true : false;
    return CircularMenu(
                radius: 80,
                alignment: Alignment.bottomCenter,
                backgroundWidget: SizedBox(
                  height: 350,
                child: Builder(builder: (context) {
                  switch (tvPopupController.indexPreimumChannelPack) {
                    case 0:
                      return ChannelTabsMobile(id: idTV, index: 0);
                    case 1:
                      return ChannelTabsMobile(id: idTV, index: 1);
                    case 2:
                      return ChannelTabsMobile(id: idTV, index: 2);
                    case 3:
                      return ChannelTabsMobile(id: idTV, index: 3);
                    case 4:
                      return ChannelTabsMobile(id: idTV, index: 4);
                    case 5:
                      return ChannelTabsMobile(id: idTV, index: 5);
                    default:
                      return ChannelTabsMobile(id: idTV, index: 0);
                  }
                }),
                ),
                toggleButtonColor: const Color(0xFFD20030),
                toggleButtonSize: 30,
                items: [
                      CircularMenuItem(
                          icon: MyFlutterApp.hispanic,
                          iconSize: 25, 
                          color: const Color(0xFFF45F25),
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(0);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "Hispanic's Premium Channels");
                          }),
                      CircularMenuItem(
                          icon: MyFlutterApp.sports2,
                          iconSize: 25,
                          color: Colors.blue,
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(1);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "Sports' Premium Channels");
                          }),
                      CircularMenuItem(
                          icon: MyFlutterApp.starz,
                          iconSize: 25,
                          color: const Color(0xFF00ABBD),
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(2);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "Straz's Premium Channels");
                          }),
                      CircularMenuItem(
                          icon: MyFlutterApp.hbo,
                          iconSize: 25,
                          color: const Color(0xFF721EDC),
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(3);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "HBO's Premium Channels");
                          }),
                      CircularMenuItem(
                          icon: MyFlutterApp.cinemax,
                          iconSize: 25,
                          color: const Color(0xFFFAB813),
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(4);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "Cinemax's Premium Channels");
                          }),
                      CircularMenuItem(
                          icon: MyFlutterApp.showtime,
                          iconSize: 25,
                          color: const Color(0xFFB40404),
                          onTap: () {
                            tvPopupController.selectedChannelPremiumPack(5);
                            tablet ?  null : tvPopupController.showChannelSnackBar(context, "Showtime's Premium Channels");
                          })
                            ],
              );
  }
}
