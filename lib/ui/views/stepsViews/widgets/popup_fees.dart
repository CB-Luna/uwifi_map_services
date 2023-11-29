import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../classes/popup.dart';
import '../../../buttons/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

class FeesPopup extends StatelessWidget with Popup {
  const FeesPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    final size = MediaQuery.of(context).size;

    const double minWidth = 900.0;
    const double maxRangeValue = 1300.0;
    final double equiv =
        (size.width < minWidth ? 0 : (size.width - minWidth)) / maxRangeValue;

    double? headerFontSize = lerpDouble(16, 20, equiv);
    double? bodyFontSize = lerpDouble(11, 14, equiv);
    double? titleFontSize = lerpDouble(25, 35, equiv);

    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      content: Container(
        padding: const EdgeInsets.all(25),
        constraints: const BoxConstraints(maxWidth: 850),
        decoration: buildBoxDecoration(
            image: 'images/bg_gradient.png',
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Broadcasting Fees',
                  style: GoogleFonts.getFont('Poppins',
                      color: const Color(0xFF2E5899),
                      fontWeight: FontWeight.w700,
                      fontSize: titleFontSize)),
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8.0),
                    controller: scrollController,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          feePara(
                              context,
                              'What are retransmission fees?',
                              'The fees that local broadcast stations charge cable operators and other multichannel video programming distributors (MVPDs) customers to show their programming.\nRetransmission consent is a provision of the 1992 United States Cable Television Consumer Protection and Competition Act that requires cable operators and other multichannel video programming distributors (MVPDs) to obtain permission from commercial broadcasters before carrying their programming.\nUnder the provision, a broadcast station (or its affiliated/parent broadcast network) can ask for monetary payment or other compensation, such as carriage of an additional channel.\nIf the cable operator rejects the broadcaster\'s proposal, the station can prohibit the cable operator from retransmitting its signal.\n',
                              headerFontSize!,
                              bodyFontSize!),
                          feePara(context, 'Additional Information:', '',
                              headerFontSize, bodyFontSize),
                          linkFormat(
                              bodyFontSize,
                              'https://www.fcc.gov/media/cable-carriage-broadcast-stations',
                              _feeLink1),
                          const SizedBox(height: 5),
                          linkFormat(
                              bodyFontSize,
                              'https://www.fcc.gov/media/policy/retransmission-consent',
                              _feeLink2),
                          feePara(
                              context,
                              '',
                              'If you are unhappy with paying these fees given they are transmitted free over the air, we would suggest you contact the folks listed below.\nPlease ask to have this provision removed the Communications Act of 1934 Also Known As the 1992 Cable Act; Cable Television Protection and Competition Act:',
                              headerFontSize,
                              bodyFontSize),
                          const SizedBox(height: 5),
                          linkFormat(bodyFontSize, 'https://www.fcc.gov/media',
                              _feeLink3),
                          const SizedBox(height: 8),
                          linkFormat(bodyFontSize,
                              'https://www.cruz.senate.gov/', _feeLink4),
                          feePara(
                              context,
                              '',
                              ' - Ted Cruz resides on the Committee on Commerce, Science, & Transportation with the Subcommittee on Communications, Media, and Broadband.\n',
                              headerFontSize,
                              bodyFontSize),
                          const SizedBox(height: 5),
                          feePara(
                              context,
                              'Your local broadcast channel General Managers.',
                              '',
                              headerFontSize,
                              bodyFontSize),
                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 5),
                          feePara(
                              context,
                              'Regional Sports Fee',
                              'To transmit the Houston Astro\'s and Rockets we must retransmit AT&T Sportsnet.  AT&T charges RTA this fee to rebroadcast this station.',
                              headerFontSize,
                              bodyFontSize)
                        ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: CustomOutlinedButton(
                    text: 'Close',
                    borderColor: const Color(0xFF2E5899),
                    bgColor: const Color(0xFF2E5899),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              )
            ]),
      ),
    );
  }

  Widget linkFormat(double bodyFontSize, String text, Function link) {
    return GestureDetector(
      child: RichText(
        text: TextSpan(children: [
          const WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(Icons.link_rounded,
                  size: 16.0, color: Color(0xFFd20030)),
            ),
          ),
          TextSpan(
            mouseCursor: SystemMouseCursors.click,
            text: text,
            style: GoogleFonts.workSans(
                fontSize: bodyFontSize,
                decoration: TextDecoration.underline,
                color: const Color(0xFFd20030),
                fontWeight: FontWeight.w500),
          ),
        ]),
      ),
      onTap: () => {link()},
    );
  }

  Widget feePara(
    BuildContext context,
    String boldtx,
    String longtx,
    double headerFontSize,
    double bodyFontSize,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          boldtx,
          style: GoogleFonts.getFont('Work Sans',
              color: const Color(0xFF2E5899),
              fontWeight: FontWeight.w700,
              fontSize: headerFontSize),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 8)),
        Flexible(
          child: Text(
            longtx,
            style: GoogleFonts.getFont('Work Sans',
                height: 1.5,
                color: const Color(0xFF2E5899),
                fontWeight: FontWeight.w500,
                fontSize: bodyFontSize),
          ),
        ),
      ],
    );
  }

  _feeLink1() async {
    if (!await launchUrl(Uri.parse(
        'https://www.fcc.gov/media/cable-carriage-broadcast-stations'))) {
      throw 'Unable to open link';
    }
  }

  _feeLink2() async {
    if (!await launchUrl(
        Uri.parse('https://www.fcc.gov/media/policy/retransmission-consent'))) {
      throw 'Unable to open link';
    }
  }

  _feeLink3() async {
    if (!await launchUrl(Uri.parse('https://www.fcc.gov/media'))) {
      throw 'Unable to open link';
    }
  }

  _feeLink4() async {
    if (!await launchUrl(Uri.parse('https://www.cruz.senate.gov'))) {
      throw 'Unable to open link';
    }
  }
}
