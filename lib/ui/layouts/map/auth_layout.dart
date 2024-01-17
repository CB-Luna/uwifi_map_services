import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/layouts/map/widgets/custom_title.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(body: chooseBody(size));
  }

  @override
  void dispose() {
    // ignore: avoid_print
    print('Entered AuthLayout dispose() - key: ${widget.key}');
    super.dispose();
  }

  Widget chooseBody(size) {
    if (size.width > 600) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: buildBoxDecoration('images/bg_image.png'),
              child: const Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomTitle(
                    mobile: true,
                  ),
                ],
              ),
            ),
          ),
          // const Expanded(child: MapView()),
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Row(
        children: [
          Container(
            decoration: buildBoxDecoration('images/bg_image.png'),
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  CustomTitle(),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height,
          //   width: size.width * 0.57,
          //   child: const MapView(),
          // ),
        ],
      ),
    );
    // );
  }
}

BoxDecoration buildBoxDecoration(String image) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(image),
      fit: BoxFit.cover,
    ),
  );
}
