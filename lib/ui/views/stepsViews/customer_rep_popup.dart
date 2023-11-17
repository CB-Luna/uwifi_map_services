// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:uwifi_map_services/classes/popup.dart';
import 'package:uwifi_map_services/router/query_params.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerRepPopup extends StatelessWidget with Popup {
  final Future<String> order;
  const CustomerRepPopup({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: FutureBuilder<String>(
        future: order,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: 250,
              width: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SpinKitCircle(
                    size: 200,
                    itemBuilder: (context, index) {
                      final colors = [
                        const Color(0xFFD20030),
                        Colors.white,
                        const Color(0xffB6D9F9)
                      ];
                      final color = colors[index % colors.length];
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontFamily: 'Work Sans',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FadeAnimatedText('Loading'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var link = json.decode(snapshot.data!)["pwlink"];
              link ??= '';
              // const link =
              //     'https://portal.southernbroadband.com:444/index.php?page=/customers/_view.php&customerid=5';
              return popupContent(context, link);
            }
          }
        },
      ),
    );
  }

  Widget popupContent(BuildContext context, String link) {
    return Container(
      width: 600,
      height: 300,
      decoration: buildBoxDecoration(
        image: 'images/blue_circles.png',
        bgColor: Colors.white,
      ),
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Customer Created!",
            style: GoogleFonts.poppins(
              height: 1.5,
              fontSize: 35,
              color: const Color(0xFFd20030),
              fontWeight: FontWeight.bold,
              letterSpacing: -1.0,
            ),
          ),
          CustomOutlinedButton(
            onPressed: () async {
              await launchUrl(Uri.parse((link)));
            },
            text: 'See Customer Profile',
            bgColor: const Color(0xFFD20030),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              primary: const Color(0xFF2e5899),
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () async {
              //Opcion 1
              // Restart.restartApp(webOrigin: 'rep/?rep=test@test.com');

              //Opcion 2
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //   '/rep/?rep=test@test.com',
              //   (Route<dynamic> route) => false,
              // );

              //Opcion 3
              // await url_launcher
              //     .launch('http://localhost:60673/#/rep/?rep=test@test.com');

              //Opcion 4
              // html.window.open(
              //     'http://localhost:50554/#/rep/?rep=test@test.com', '_self');

              //Opcion 5
              // NavigationService.navigateTo('/rep/?rep=test@test.com');

              //Opcion 6
              Navigator.of(context).popUntil(
                ModalRoute.withName(
                  '/rep/?rep=${QueryParams.instance?.customerRep}',
                ),
              );
            },
            child: Text(
              'Close',
              style: GoogleFonts.workSans(
                height: 1.5,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
