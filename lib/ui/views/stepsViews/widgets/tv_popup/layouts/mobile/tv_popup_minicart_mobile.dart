import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/minicart_tv_mobile.dart';

final _scrollControllerAllPopUp = ScrollController();
const Color blueColor = Color(0xCC2372F0);
const Color iconBackgroundColor = Color(0xFF647082);
final BorderRadius optionBorderRadius = BorderRadius.circular(8);

class TVPopupMinicartMobile extends StatelessWidget with Popup {
  final Plan plan;
  const TVPopupMinicartMobile({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: 380,
      child: Stack(
        children: [
          _Background(
            width: width * 0.4,
            height: height * 0.8,
          ),
          SingleChildScrollView(
            controller: _scrollControllerAllPopUp,
            child: Column(
              children: const [
                SizedBox(
                  height: 5,
                ),
                _AppBar(),
                SizedBox(
                  height: 15,
                ),
                MiniCartTVMobile()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final double width, height;

  const _Background({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage('images/bg_gradient.png'),
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
