import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/classes/plan.dart';
import '../../../../../classes/popup.dart';
import 'tabs/info_tab.dart';

class InternetPopup extends StatelessWidget with Popup {
  final Plan plan;
  final String customerRep;

  const InternetPopup({
    Key? key,
    required this.plan,
    required this.customerRep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var descriptionFormat = plan.description!.replaceAll('<ul>', '');
    descriptionFormat = descriptionFormat.replaceAll('</p>', '\n');
    descriptionFormat = descriptionFormat.replaceAll('<p>', '');
    descriptionFormat = descriptionFormat.replaceAll('<br>', '');
    descriptionFormat = descriptionFormat.replaceAll('</ul>', '');
    descriptionFormat = descriptionFormat.replaceAll('<li>', '•');
    descriptionFormat = descriptionFormat.replaceAll('</li>', '\n');
    const String eqInfo = '''
WiFi is not meant to provide full bandwidth to each device, but if connected within range of the router/access point, should be able to give enough speed to complete any task needed for your device on the internet. 

WiFi uses radio frequencies to transmit signal from the router to your device. The further away you are from the router with your device, the less signal therefore the less internet (speed) you will receive.

If you have multiple walls between you and the router/access point, this can impact your signal and reduce the amount of internet you can receive at your device.
''';

    final scrollController = ScrollController();
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 600 ? true : false;
    const double mobileTitle = 12;
    const double mobileText = 10.5;
    double boxPadding = mobile ? 20.0 : 30.0;

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      content: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          constraints: BoxConstraints(
              maxHeight: mobile ? double.infinity : 570, maxWidth: 850),
          decoration: buildBoxDecoration(
              image: mobile ? 'images/bg_image.png' : 'images/sideCircles.png',
              fit: BoxFit.cover,
              alignment: Alignment.center),
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            FractionallySizedBox(
              widthFactor: mobile ? 1.0 : 0.5,
              child: Container(
                  padding: EdgeInsets.all(boxPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Wrap(children: [
                          FractionallySizedBox(
                            widthFactor: mobile ? 0.6 : 1.0,
                            child: SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                              'images/icon_gigFastInternet.png',
                                              width: 50,
                                              height: 50),
                                          const SizedBox(width: 15),
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(plan.name!,
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 25,
                                                        color: const Color(
                                                            0xFF2e5899),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: -0.5)),
                                                Text(plan.featTitle!,
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 12,
                                                        color: const Color(
                                                            0xFFd20030),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.5)),
                                                Text(plan.featDesc!,
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 12,
                                                        color: const Color(
                                                            0xFFd20030),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: -0.5)),
                                              ]),
                                        ]),
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("\$${plan.price}",
                                            style: GoogleFonts.workSans(
                                                fontSize: 26,
                                                color: const Color(0xFF2e5899),
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: -1.0)),
                                        Text("/mo",
                                            style: GoogleFonts.workSans(
                                                fontSize: 16,
                                                color: const Color(0xFF2e5899),
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: -1.0))
                                      ])
                                ],
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            alignment: Alignment.topLeft,
                            widthFactor: mobile ? 0.4 : 1.0,
                            child: Padding(
                              padding: EdgeInsets.only(left: mobile ? 15.0 : 0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("No contracts required",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFFd20030),
                                          fontSize: mobile ? mobileTitle : 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.5,
                                        )),
                                  ]),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 5),
                        Text(descriptionFormat,
                            style: GoogleFonts.workSans(
                                height: 1.5,
                                fontSize: mobile ? mobileText : 12,
                                color: const Color(0xFF8AA7D2),
                                fontWeight: descriptionFormat.length > 200
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                letterSpacing: -0.2)),
                        const SizedBox(height: 5),
                        Column(
                          children: [
                            Text("How does Wi-Fi work?",
                                style: GoogleFonts.workSans(
                                    height: 1.5,
                                    fontSize: mobile ? mobileTitle : 16,
                                    color: const Color(0xFF2e5899),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: mobile ? 60 : 80,
                          child: Scrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(8.0),
                              controller: scrollController,
                              child: Text(eqInfo,
                                  style: GoogleFonts.workSans(
                                      height: 1.5,
                                      fontSize: mobile ? mobileText : 12,
                                      color: const Color(0xFF8AA7D2),
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: -0.2)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: const Color(0xFFd20030),
                              minimumSize: const Size.fromHeight(50)),
                          onPressed: () => Navigator.pop(context, 'Accept'),
                          child: Text('Accept',
                              style: GoogleFonts.workSans(
                                  height: 1.5,
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2)),
                        ),
                      ])),
            ),
            FractionallySizedBox(
                widthFactor: mobile ? 1.0 : 0.5, child: const InfoTab()),
          ]),
        ),
        Positioned(
          right: 0.0,
          top: 0.0,
          child: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              splashRadius: 10.0,
              icon: const Icon(
                Icons.close,
                color: Color(0xff8aa7d2),
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ]),
    );
  }
}
