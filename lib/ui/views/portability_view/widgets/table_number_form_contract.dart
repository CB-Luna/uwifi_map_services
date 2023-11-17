import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';


class TableNumberFormContract extends StatelessWidget {
  const TableNumberFormContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portabilityFormProvider = Provider.of<PortabilityFormProvider>(context);
    final TextStyle style = GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(  
          color: Colors.black,  
          style: BorderStyle.solid,  
          width: 2),  
        children: [
           TableRow(
            children: [
              TableCell(
                child: Text(
                'Telephone Number',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
              ),
              TableCell(
                child: Text(
                "Billing Telephone Number", 
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
                ),
              ),
              TableCell(
                child: Text(
                  "Requested Port Date",
                  style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          for (var index = 0; index < portabilityFormProvider.fields.length; index++) 
          TableRow(
                children: [
                  TableCell(
                    child: Text(
                      portabilityFormProvider.telephoneNumber[index],
                      style: style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TableCell(
                    child: Text(
                      portabilityFormProvider.billingTelephone[index],
                      style: style,
                      textAlign: TextAlign.center,
                      ),
                  ),
                  TableCell(
                    child: Text(
                      portabilityFormProvider.requestedPortDate,
                      style: style,
                      textAlign: TextAlign.center,
                      ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
//Un cambio