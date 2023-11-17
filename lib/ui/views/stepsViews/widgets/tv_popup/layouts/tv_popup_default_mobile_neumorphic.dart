import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/circular_taps_menu.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/additional_tabs_mobile.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/view_features_package.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/rta_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_movie_channels_bundle.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_set_top_box.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_supported_devices.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/tv_popup_title_mobile.dart';

final _scrollControllerAllPopUp = ScrollController();
final _scrollControllerAppbarSection = ScrollController();
final _scrollControllerTitleSection = ScrollController();
final _scrollControllerOptionsSection = ScrollController();
const Color blueColor = Color(0xCC2372F0);
const Color iconBackgroundColor = Color(0xFF647082);
final BorderRadius optionBorderRadius = BorderRadius.circular(8);

class TVDefaultMobileNeumorphic extends StatelessWidget with Popup {
  final Plan plan;
  const TVDefaultMobileNeumorphic({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Scaffold(
        body: Stack(
          children: [
            const _Background(),
            SingleChildScrollView(
              controller: _scrollControllerAllPopUp,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const _AppBar(),
                  _Title(
                    plan: plan,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _SettingAndOptions(),
                  const SizedBox(
                    height: 5,
                  ),
                  _ContainerSettingAndOptions(
                      idTV: plan.id, description: plan.description!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContainerSettingAndOptions extends StatelessWidget {
  final String idTV;
  final String description;
  const _ContainerSettingAndOptions(
      {Key? key, required this.idTV, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    final cartController = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollControllerOptionsSection,
        scrollDirection: Axis.horizontal,
        child: Builder(builder: (context) {
          switch (tvPopupController.indexContainer) {
            case 0:
              return ViewFeaturesPackage(idTV: idTV, description: description);
            case 1:
              return TVPopupMovieChannelsBundle(idTV: idTV);
            case 2:
              return AdditionalTabsMobile(idTV: idTV);
            case 3:
              return CircularTapsMenu(idTV: idTV);
            case 4:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TVPopupSupportedDevices(),
                  const SizedBox(height: 10),
                  cartController.isSupportedDevicesVisible
                      ? const TVPopupSetTopBox()
                      : RTASetTopBox(idTV: idTV),
                ],
              );
            default:
              return TVPopupMovieChannelsBundle(idTV: idTV);
          }
        }),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage('images/blue_circles.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final tvPopupController = Provider.of<TVPopupController>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              tvPopupController.restartIndexTVPopup();
              tvPopupController.selectedOptions(0);
              tvPopupController.selectedOptionsChannels(0);
              Navigator.pop(context);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ClayContainer(
                height: 50,
                width: 50,
                depth: 20,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: iconBackgroundColor.withOpacity(0.2), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.close_outlined,
                    color: iconBackgroundColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => tvPopupController.changeView(2),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ClayContainer(
                height: 50,
                width: 50,
                depth: 20,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: iconBackgroundColor.withOpacity(0.2), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: badge.Badge(
                    badgeContent: Text(
                        cartController.badgeCounterTotal.toString(),
                        style: const TextStyle(color: Colors.white)),
                    showBadge:
                        cartController.badgeCounterTotal == 0 ? false : true,
                    badgeColor: const Color(0xFFD20030),
                    position: badge.BadgePosition.bottomStart(),
                    elevation: 4,
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: iconBackgroundColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final Plan plan;

  const _Title({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        controller: _scrollControllerTitleSection,
        scrollDirection: Axis.horizontal,
        child: TVPopupTitleMobile(
          name: plan.name!,
          featTitle: plan.featTitle!,
          price: plan.price!.toString(),
        ),
      ),
    );
  }
}

class _SettingAndOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollControllerAppbarSection,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
        child: Row(
          children: const <Widget>[
            _OptionsWidget(),
          ],
        ),
      ),
    );
  }
}

class _OptionsWidget extends StatelessWidget {
  const _OptionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int index = 0; index < options.length; index++)
          _OptionWidget(option: options[index], index: index),
      ],
    );
  }
}

class _OptionWidget extends StatelessWidget {
  final Option option;
  final int index;
  const _OptionWidget({Key? key, required this.option, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    return InkWell(
      onTap: () {
        tvPopupController.selectedOptions(index);
        tvPopupController.showActionSnackBar(context, index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Material(
          elevation: 8,
          borderRadius: optionBorderRadius,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: optionBorderRadius,
              color: options[index].isSelected!
                  ? const Color(0xFFD20030)
                  : Colors.white,
            ),
            child: Icon(
              option.icon,
              color: options[index].isSelected!
                  ? Colors.white
                  : iconBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
