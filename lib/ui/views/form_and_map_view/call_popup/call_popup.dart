import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/location_phone_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/constants.dart';
import '../../../inputs/custom_inputs.dart';
import '../wigdets/gradient_button.dart';

class PopupFormZip extends StatefulWidget {
  const PopupFormZip({
    Key? key,
  }) : super(key: key);

  @override
  State<PopupFormZip> createState() => _PopupFormZipState();
}

class _PopupFormZipState extends State<PopupFormZip> {
  final TextEditingController zipController = TextEditingController();
  final CustomInputs _customInputs = CustomInputs();
  final _formKey = GlobalKey<FormState>();

  late Future<dynamic> _futureResult;
  bool _buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    final lpController = Provider.of<LocationPhoneController>(context);

    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(alignment: Alignment.topRight, children: [
        ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 500,
              maxWidth: 700,
            ),
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: mobile(context) ? 60 : 20,
                    horizontal: mobile(context) ? 30 : 100),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Color(0XFFCEE6FF)]),
                  borderRadius: BorderRadius.circular(250),
                ),
                child: SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.center,
                    runSpacing: 10,
                    children: [
                      Text("Call your local office",
                          textAlign: TextAlign.center,
                          style: titleStyle(context)),
                      FractionallySizedBox(
                          widthFactor: 1,
                          child: Text(
                            "Find out exactly what services RTA has to offer in your hometown. Input your zip code for your local office phone number.",
                            style: bodyStyle(context,
                                fontSize: 14,
                                color:
                                    const Color(0xFF2E5899).withOpacity(0.75)),
                            textAlign: TextAlign.center,
                          )),
                      FractionallySizedBox(
                        widthFactor: mobile(context) ? 1 : 0.4,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                              controller: zipController,
                              decoration: _customInputs.formInputDecoration(
                                label: "Zip Code",
                                icon: Icons.map_rounded,
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autocorrect: false,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                final phoneCharacters =
                                    RegExp(r'^[0-9\-() ]+$');
                                final valueLength = value?.length ?? 0;
                                return phoneCharacters.hasMatch(value ?? '')
                                    ? valueLength >= 5
                                        ? null
                                        : "Minimun length: 5"
                                    : 'Please enter valid data';
                              },
                              style: bodyStyle(context, fontSize: 14)),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: mobile(context) ? 1 : 0.4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CustomOutlinedButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              text: "Check Now",
                              onPressed: () {
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _futureResult = lpController
                                          .getLocationData(zipController.text);

                                      _buttonPressed = true;
                                    });
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }),
                        ),
                      ),
                      FractionallySizedBox(
                          widthFactor: 1,
                          child: _buttonPressed
                              ? FutureBuilder<dynamic>(
                                  future: _futureResult,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    Widget result;

                                    if (snapshot.hasData) {
                                      result = Column(
                                        children: [
                                          Visibility(
                                            visible: snapshot.data['siteid']
                                                .contains("RTA"),
                                            child: Text(
                                              "Unfortunately, RTA is not currently available in your area. However, RTA is continuing to expand across America. If you are interested in RTA’s services in your area, please send us an email or call to our main office.",
                                              textAlign: TextAlign.center,
                                              style: bodyStyle(context,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                snapshot.data['location'],
                                                textAlign: TextAlign.center,
                                                style: subtitleStyle(context,
                                                    fontSize: 18)),
                                          ),
                                          GradientButtonWidget(
                                            function: () => launchUrl(Uri.parse(
                                                ("tel:${snapshot.data['phone']}"))),
                                            text: snapshot.data['phone'],
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      result = Text(
                                          "There was an error during the search",
                                          style: bodyStyle(context));
                                    } else {
                                      result =
                                          const CircularProgressIndicator();
                                    }
                                    return Center(child: result);
                                  })
                              : const SizedBox.shrink()),
                    ],
                  ),
                ))),
        Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: IconButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 2,
              color: const Color(0XFF2e5899),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, size: 14)),
        )
      ]),
    );
  }
}
