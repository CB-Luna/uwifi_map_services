import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';
import 'package:uwifi_map_services/ui/views/portability_view/widgets/table_number_form_contract.dart';

class SegmentContract extends StatelessWidget {
  const SegmentContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    return Card(
      elevation: 5.0,
      color: Colors.white.withOpacity(0.7),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22)), 
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            getTextFieldLetter('Name on Account', '${portabilityFormProvider.portFirstName} ${portabilityFormProvider.portLastName}'),
            
            getTextFieldLetter('Service Address', portabilityFormProvider.portNumberStreet),
            Center(
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 15,
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
          
            const SizedBox(height: 10,),
          
          
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