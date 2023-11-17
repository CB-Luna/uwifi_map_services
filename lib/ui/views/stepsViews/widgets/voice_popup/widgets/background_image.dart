import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        //Para colocar el logo
        constraints: const BoxConstraints(maxWidth: 400),
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:
                      30.0), //se le agrega un padding horizontal al logo para que no pegue on los bordes
              child: Stack(
                alignment: Alignment.center,
                children: const [
                  Image(
                    image: AssetImage('images/swipes.png'),
                    width: 450,
                  ),
                  Image(
                    image: AssetImage('images/phone.png'),
                    width: 400,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/blue_bg_image.jpg'), fit: BoxFit.cover),
    );
  }
}
