import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option_channel.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/tap_view_channels_see_more_mobile.dart';

final _scrollControllerAllPopUp = ScrollController();
final _scrollControllerAppbarSection = ScrollController();
final _scrollControllerTitleSection = ScrollController();
final _scrollControllerOptionsSection = ScrollController();
const Color blueColor = Color(0xFF2e5899);
const Color iconBackgroundColor = Color.fromARGB(255, 88, 92, 99);
const Color backgroundColor = Color(0xFF647082);
final BorderRadius optionBorderRadius = BorderRadius.circular(8);

class ChannelsLineupMobile extends StatelessWidget {
  final String id;
  const ChannelsLineupMobile({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Stack(
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
                const SizedBox(
                  height: 5,
                ),
                _Title(
                  id: id,
                ),
                const SizedBox(
                  height: 5,
                ),
                _SettingAndOptions(),
                const SizedBox(
                  height: 5,
                ),
                _ContainerSettingAndOptions(idTV: id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.center,
          image: AssetImage('images/bg_image.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => tvPopupController.changeView(0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ClayContainer(
                height: 50,
                width: 50,
                depth: 15,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: iconBackgroundColor.withOpacity(0.2), width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: iconBackgroundColor,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String id;

  const _Title({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPopupController = Provider.of<TVPopupController>(context);
    List channelsAvailable = tvPopupController.getChannelsAvailableSeeMore(
        tvPopupController.allChannels, id);
    final numberHDChannels = channelsAvailable.length;
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          controller: _scrollControllerTitleSection,
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${id.replaceAll('tv', '')} Package',
                style: GoogleFonts.workSans(
                    height: 1.5,
                    fontSize: 26,
                    color: blueColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3),
              ),
              Text(
                '$numberHDChannels HD Channels',
                style: GoogleFonts.workSans(
                    height: 1.5,
                    fontSize: 22,
                    color: const Color(0xFFd20030),
                    fontWeight: FontWeight.w300,
                    letterSpacing: -0.3),
              )
            ],
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
        for (int index = 0; index < optionsChannel.length; index++)
          _OptionWidget(option: optionsChannel[index], index: index),
      ],
    );
  }
}

class _OptionWidget extends StatelessWidget {
  final OptionChannel option;
  final int index;
  const _OptionWidget({Key? key, required this.option, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TVPopupController>(context);
    return InkWell(
      onTap: () {
        controller.selectedOptionsChannels(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Material(
          elevation: 8,
          borderRadius: optionBorderRadius,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: optionBorderRadius,
              color: optionsChannel[index].isSelected!
                  ? const Color(0xFFD20030)
                  : Colors.white,
            ),
            child: Icon(
              option.icon,
              color: optionsChannel[index].isSelected!
                  ? Colors.white
                  : iconBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContainerSettingAndOptions extends StatelessWidget {
  final String idTV;
  const _ContainerSettingAndOptions({Key? key, required this.idTV})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TVPopupController>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        controller: _scrollControllerOptionsSection,
        scrollDirection: Axis.horizontal,
        child: Builder(builder: (context) {
          switch (controller.indexContainerChannels) {
            case 0:
              return getSizedBox(idTV, controller.allChannels, 0);
            case 1:
              return getSizedBox(idTV, controller.allChannels, 1);
            case 2:
              return getSizedBox(idTV, controller.sportsChannels, 2);
            case 3:
              return getSizedBox(idTV, controller.newsChannels, 3);
            case 4:
              return getSizedBox(idTV, controller.moviesChannels, 4);
            case 5:
              return getSizedBox(idTV, controller.musicChannels, 5);
            case 6:
              return getSizedBox(idTV, controller.kidsChannels, 6);
            default:
              return getSizedBox(idTV, controller.allChannels, 0);
          }
        }),
      ),
    );
  }

  Widget getSizedBox(String idTV, List<dynamic> channels, index) {
    return TapViewChannelsSeeMoreMobile(
        idTV: idTV, channels: channels, index: index);
  }
}
