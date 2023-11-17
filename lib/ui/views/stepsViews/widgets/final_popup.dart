import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/portability_form_provider.dart';

class FinalPopup extends StatelessWidget {
  const FinalPopup({Key? key}) : super(key: key);

  //El slider de extensiones sigue pendiente
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 950 ? true : false;
    final portabilityFormProvider =
        Provider.of<PortabilityFormProvider>(context);
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      backgroundColor: Colors.white,
      content: Container(
        padding: const EdgeInsets.all(20.0),
        width: 600,
        decoration: buildBoxDecoration('images/bg_gradient.png'),
        child: Container(
          padding: EdgeInsets.all(mobile ? 10.0 : 25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thank you!",
                style: GoogleFonts.poppins(
                  height: 1.5,
                  fontSize: 35,
                  color: const Color(0xFFd20030),
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.0,
                ),
              ),
              Text(
                "Your order was placed successfully.\nWe'll get in contact with you soon!",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  height: 1.5,
                  fontSize: mobile ? 16 : 24,
                  color: const Color(0xFF2e5899),
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.50,
                ),
              ),
              portabilityFormProvider.fileSelected ||
                      portabilityFormProvider.portabilityCheck == false
                  ? const Text(
                      "",
                    )
                  : Text(
                      "If you don't have your last bill right now you can go to https://rtatel.com/ later to upload",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        height: 1.5,
                        fontSize: mobile ? 14 : 20,
                        color: const Color(0xFF2e5899),
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.50,
                      ),
                    ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: const Color(0xFF2e5899),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () => Restart.restartApp(webOrigin: '/'),
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
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration(String image) {
    return BoxDecoration(
      image: DecorationImage(
        alignment: Alignment.bottomCenter,
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    );
  }
}