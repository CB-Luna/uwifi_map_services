import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/data/constants.dart';

import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/providers/selector_summary_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_outlined_button.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/voice_popup/widgets/step_bloc_item.dart';
import 'package:url_launcher/url_launcher.dart';

class SignFormView extends StatelessWidget {
  const SignFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    final selectorSummaryController =
        Provider.of<SelectorSummaryController>(context);
    final size = MediaQuery.of(context).size;
    final mobile = size.width < 1000 ? true : false;
    return Form(
      key: portabilityFormProvider.signFormKey,
      child: Container(
        // color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You can go back to modify your data before continue to sign the letter',
                style: GoogleFonts.poppins(
                  fontSize: mobile ? 15 : 22,
                  height: 1.5,
                  color: const Color(0xff2E5899),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'If already your all information is okay, read the next steps:',
                style: GoogleFonts.poppins(
                  fontSize: mobile ? 12 : 15,
                  height: 1.5,
                  color: const Color(0xff001E4D),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const StepBlocItem(
                  stepNumber: "1",
                  description:
                      "Click on the red buttom below 'Continue to Sign', you will redirect to another tab where displays whole Letter of Authorization."),
              const StepBlocItem(
                  stepNumber: "2",
                  description:
                      "Accept the Terms of use clicking on blue button 'Continue'."),
              const StepBlocItem(
                  stepNumber: "3",
                  description:
                      "The Letter shows your input information, so just search the sign area with the label 'Click here to sign'."),
              const StepBlocItem(
                  stepNumber: "4",
                  description:
                      "A new popup will display, next typing or drawing your signature and click on blue button 'Apply'."),
              StepBlocItem(
                  stepNumber: "5",
                  description:
                      "Click on the blue button 'Click to Sign' and write the same email address that you input previously in the section Personal Details. This one: ${portabilityFormProvider.portEmail}"),
              const StepBlocItem(
                  stepNumber: "6",
                  description:
                      "Click on the blue button 'Click to sign', verify and confirm the mail that you will receive, you even can print the copy of letter if you want."),
              const StepBlocItem(
                  stepNumber: "7",
                  description:
                      "Finally click on the below red button 'Continue' to move on next step."),
              const SizedBox(height: 15),
              Center(
                child: portabilityFormProvider.availableContinue
                    ? CustomOutlinedButton(
                        onPressed: () async {
                          if (await portabilityFormProvider
                              .getDocumentLOAPortability(
                                  portabilityFormProvider.portEmail)) {
                            selectorSummaryController.changeView(7);
                          } else {
                            Flushbar(
                              backgroundColor: const Color(0xFFD20030),
                              message:
                                  "You must sign the document and confim the mail you'll recibe to you can 'Continue'",
                              duration: const Duration(seconds: 4),
                            ).show(context);
                          }

                          // selectorSummaryController.changeView(6);
                        },
                        text: 'Continue')
                    : Center(
                        child: Wrap(
                          spacing: 15,
                          runSpacing: 5,
                          alignment: WrapAlignment.center,
                          children: [
                            CustomOutlinedButton(
                              onPressed: () {
                                selectorSummaryController
                                    .changePortabilityView(5);
                              },
                              text: 'Back',
                              bgColor: const Color(0xff2E5899),
                              borderColor: const Color(0xff2E5899),
                            ),
                            CustomOutlinedButton(
                              onPressed: () async {
                                portabilityFormProvider.portInitials =
                                    "${portabilityFormProvider.portFirstName[0]}. ${portabilityFormProvider.portLastName[0]}."
                                        .toUpperCase();
                                switch (portabilityFormProvider
                                    .counterNumbersForm) {
                                  case 0:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&PD1=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 1:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 2:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 3:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 4:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 5:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 6:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 7:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 8:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&TN9=${portabilityFormProvider.telephoneNumber[8]}&BT9=${portabilityFormProvider.billingTelephone[8]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&PD9=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 9:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&TN9=${portabilityFormProvider.telephoneNumber[8]}&BT9=${portabilityFormProvider.billingTelephone[8]}&TN10=${portabilityFormProvider.telephoneNumber[9]}&BT10=${portabilityFormProvider.billingTelephone[9]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&PD9=${portabilityFormProvider.requestedPortDate}&PD10=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 10:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&TN9=${portabilityFormProvider.telephoneNumber[8]}&BT9=${portabilityFormProvider.billingTelephone[8]}&TN10=${portabilityFormProvider.telephoneNumber[9]}&BT10=${portabilityFormProvider.billingTelephone[9]}&TN11=${portabilityFormProvider.telephoneNumber[10]}&BT11=${portabilityFormProvider.billingTelephone[10]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&PD9=${portabilityFormProvider.requestedPortDate}&PD10=${portabilityFormProvider.requestedPortDate}&PD11=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  case 11:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&TN9=${portabilityFormProvider.telephoneNumber[8]}&BT9=${portabilityFormProvider.billingTelephone[8]}&TN10=${portabilityFormProvider.telephoneNumber[9]}&BT10=${portabilityFormProvider.billingTelephone[9]}&TN11=${portabilityFormProvider.telephoneNumber[10]}&BT11=${portabilityFormProvider.billingTelephone[10]}&TN12=${portabilityFormProvider.telephoneNumber[11]}&BT12=${portabilityFormProvider.billingTelephone[11]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&PD9=${portabilityFormProvider.requestedPortDate}&PD10=${portabilityFormProvider.requestedPortDate}&PD11=${portabilityFormProvider.requestedPortDate}&PD12=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                  default:
                                    await launchUrl(Uri.parse(
                                        "$adobeSign#Name=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Address=${portabilityFormProvider.portNumberStreet}&City=${portabilityFormProvider.portCity}&State=${portabilityFormProvider.portState}&Zipcode=${portabilityFormProvider.portZipcode}&Service_Provider=${portabilityFormProvider.currentServiceProvider}&TN1=${portabilityFormProvider.telephoneNumber[0]}&BT1=${portabilityFormProvider.billingTelephone[0]}&TN2=${portabilityFormProvider.telephoneNumber[1]}&BT2=${portabilityFormProvider.billingTelephone[1]}&TN3=${portabilityFormProvider.telephoneNumber[2]}&BT3=${portabilityFormProvider.billingTelephone[2]}&TN4=${portabilityFormProvider.telephoneNumber[3]}&BT4=${portabilityFormProvider.billingTelephone[3]}&TN5=${portabilityFormProvider.telephoneNumber[4]}&BT5=${portabilityFormProvider.billingTelephone[4]}&TN6=${portabilityFormProvider.telephoneNumber[5]}&BT6=${portabilityFormProvider.billingTelephone[5]}&TN7=${portabilityFormProvider.telephoneNumber[6]}&BT7=${portabilityFormProvider.billingTelephone[6]}&TN8=${portabilityFormProvider.telephoneNumber[7]}&BT8=${portabilityFormProvider.billingTelephone[7]}&TN9=${portabilityFormProvider.telephoneNumber[8]}&BT9=${portabilityFormProvider.billingTelephone[8]}&TN10=${portabilityFormProvider.telephoneNumber[9]}&BT10=${portabilityFormProvider.billingTelephone[9]}&TN11=${portabilityFormProvider.telephoneNumber[10]}&BT11=${portabilityFormProvider.billingTelephone[10]}&TN12=${portabilityFormProvider.telephoneNumber[11]}&BT12=${portabilityFormProvider.billingTelephone[11]}&PD1=${portabilityFormProvider.requestedPortDate}&PD2=${portabilityFormProvider.requestedPortDate}&PD3=${portabilityFormProvider.requestedPortDate}&PD4=${portabilityFormProvider.requestedPortDate}&PD5=${portabilityFormProvider.requestedPortDate}&PD6=${portabilityFormProvider.requestedPortDate}&PD7=${portabilityFormProvider.requestedPortDate}&PD8=${portabilityFormProvider.requestedPortDate}&PD9=${portabilityFormProvider.requestedPortDate}&PD10=${portabilityFormProvider.requestedPortDate}&PD11=${portabilityFormProvider.requestedPortDate}&PD12=${portabilityFormProvider.requestedPortDate}&Name2=${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}&Current_Date=${portabilityFormProvider.formattedDate}&Initials=${portabilityFormProvider.portInitials}"));
                                    break;
                                }
                                portabilityFormProvider.changeButtons(true);
                              },
                              text: 'Continue To Sign',
                              bgColor: const Color(0xFFD20030),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





//Un cambio