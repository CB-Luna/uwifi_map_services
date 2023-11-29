// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:uwifi_map_services/ui/layouts/map/widgets/custom_title_r.dart';
import 'package:uwifi_map_services/ui/views/referral/form_view_r.dart';

class AuthLayoutR extends StatelessWidget {
  const AuthLayoutR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return chooseBody(size);
  }

  Widget chooseBody(size) {
    if (size.width > 800) {
      return const _DesktopBody();
    } else {
      return const _MobileBody();
    }
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: const DecorationImage(
          alignment: Alignment.center,
          image: AssetImage('images/bg_image.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomTitleR(),

            Expanded(
              child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                      controller: scrollController,
                      //primary: true,
                      child: const FormViewR())),
            ),
            // Expanded(
            //   flex:1,
            //   child: BackgroundImage()
            // ),
          ],
        ),
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();

    final size = MediaQuery.of(context).size;

    //como el listview requiere que todos sus hijos tengan el mismo tamaño para
    //hacer scroll, el container debe tener un tamaño especifico
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 800, maxWidth: 900),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            alignment: Alignment.center,
            image: AssetImage('images/bg_image.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        height: size.height / 1,
        width: size.width * 0.8,
        child: Center(
          child: Container(
            width: 820,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CustomTitleR(),
                Expanded(
                    child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: SingleChildScrollView(
                            controller: scrollController,
                            child: const FormViewR())))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
