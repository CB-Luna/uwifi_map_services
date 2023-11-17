import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/table_number_form_contract.dart';

class CreateContract extends StatelessWidget {
  const CreateContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.8)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        controller: portabilityFormProvider.scrollControllerLetter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 50,
                child: Image.asset(
                  'images/gigFastVoice.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
             
            const SizedBox(height: 10,),
      
            Center(
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.contain,
                child: Text(
                  'Letter of Authorization ',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: Text(
                  'Dear Customer:',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
            ), 
            const SizedBox(height: 10,),
            SizedBox(
              child: Text(
                  'Thank you for choosing Rural Telecommunications of America (RTA) as your service provider. As you are aware, you may continue to use your existing telephone number with gigFAST VoIP service. To transition your current telephone number to gigFAST VoIP service, RTA must work with your previous service provider to ensure that your service is uninterrupted, and where applicable, to ensure that your number is transferred.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.justify,
                ),
            ), 
            const SizedBox(height: 10,),
            SizedBox(
              child: Text(
                  'Your prior service provider requires this letter as proof that you have explicitly authorized and requested that your service and current telephone number be transferred to another service provider. By filling in all the information requested below, and signing and dating this letter, you provide us with the authorization to initiate the process of transferring your service and telephone number to gigFAST VoIP Services. You will then be able to use your old number with your new gigFAST VoIP service.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.justify,
                ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              child: Text(
                  'Please ensure the following information is complete accurately which will help prevent possible delays.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.justify,
                ),
            ),
            const SizedBox(height: 10,),
            getTextFieldLetter('Name on Account', '${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}'),
            
            getTextFieldLetter('Service Address', portabilityFormProvider.portNumberStreet),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 5,
                children:
                [
                  getTextFieldLetter('State', portabilityFormProvider.portState),
                  getTextFieldLetter('Zipcode', portabilityFormProvider.portZipcode),
                  getTextFieldLetter('City', portabilityFormProvider.portCity),
      
                ]
              ),
            ),
            getTextFieldLetter('Current Servide Provider', portabilityFormProvider.currentServiceProvider),

            const TableNumberFormContract(),

            SizedBox(
              child: Text(
                  'PLEASE REMOVE ANY FEATURES (i.e. Hunt Group) ASSOCIATED WITH THESE NUMBERS PRIOR TO SUBMITTING THIS LOA. ADDITIONALY, PLEASE DO NOT PLACE ANY NEW SERVICE ORDERS WITH YOUR CURRENT SERVICE PROVIDER ON THIS ACCOUNT, AS THIS WILL CAUSE A DELAY IN PORTING YOUR NUMBERS.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.justify,
                ),
            ),
            const SizedBox(height: 10,),

            SizedBox(
              child: Text(
                  'By signing below, I designate RTA or its designated agent to transfer my service from my current provider to RTA. By signing below, I also authorize RTA or its designated agent to transfer my current telephone number used to provide service so that RTA may provide its service to me. By signing below, I also authorize RTA or its designated agent to obtain billing information, customer service records and other network information required to provide me with RTA service. I understand that I may consult with RTA as to whether a fee will apply to the change.',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.justify,
                ),
            ),

            const SizedBox(height: 25,),

            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 25,
                runSpacing: 10,
                children: [
                  getTextFieldLetter('Signature', '__________'),
                  getTextFieldLetter('Date', portabilityFormProvider.getFormattedDateNow()),
                ],
              ),
            ),

            const SizedBox(height: 25,),

            SizedBox(
              child: Text(
                  'A bill copy is REQUIRED to authorize ownership of number(s). Please include a summary copy containing account name and the numbers owned. See your Sales Representative for further information.',
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.justify,
                ),
            ),


          ],
        ),
      ),
    );
  }


  SizedBox getTextFieldLetter(String field, String value) {
    return SizedBox(
            child: Wrap(
              children: [
                Text(
                    '$field: ',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                    )
                  ),
              ],
            ),);
  }


}