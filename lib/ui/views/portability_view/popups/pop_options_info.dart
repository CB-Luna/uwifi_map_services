import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uwifi_map_services/providers/referal_providers/portability_form_provider_r.dart';
import 'package:uwifi_map_services/ui/views/portability_view/popups/pop_referral_added.dart';

import '../../stepsViews/widgets/column_builder.dart';

class PopOptionsInfo extends StatelessWidget {
  const PopOptionsInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 500 ? true : false;
    final portabilityFormProvider =
        Provider.of<PortabilityFormProviderR>(context);
    final sizeWidth = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();
    return Container(
      padding: const EdgeInsets.all(10),
      height: 500,
      width: 660,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "We found multiple accounts according to your information. Please select the one you want to use.",
            style: GoogleFonts.poppins(
              fontSize: mobile ? 12 : 25,
              height: 1.4,
              color: const Color(0xff2E5899),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            width: sizeWidth * 0.75,
            height: 350,
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF2e5899),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: Text("Please choose one",
                            style: GoogleFonts.workSans(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -1.0)))),
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 20,
                            margin: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFEDFF),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 0, 0, 0),
                              child: Text('Accounts Found',
                                  style: GoogleFonts.workSans(
                                      fontSize: 14,
                                      color: const Color(0xff3C7DCA),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5)),
                            ),
                          ),
                          ColumnBuilder(
                            itemCount: portabilityFormProvider.totalOptions,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(
                                    '${portabilityFormProvider.resultOptionsInfo![index].firstName} ${portabilityFormProvider.resultOptionsInfo![index].lastName}',
                                    style: GoogleFonts.workSans(
                                        fontSize: 14,
                                        color: const Color(0xff2e5899),
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5)),
                                subtitle: Text(
                                    '${portabilityFormProvider.resultOptionsInfo![index].street}, ${portabilityFormProvider.resultOptionsInfo![index].zipcode}, ${portabilityFormProvider.resultOptionsInfo![index].city}, ${portabilityFormProvider.resultOptionsInfo![index].state}',
                                    style: GoogleFonts.workSans(
                                        fontSize: 12,
                                        color: const Color(0xff2e5899),
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5)),
                                trailing: Text(
                                    portabilityFormProvider
                                        .resultOptionsInfo![index].email!,
                                    style: GoogleFonts.workSans(
                                        fontSize: 14,
                                        color: const Color(0xff2e5899),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.5)),
                                onTap: () {
                                  portabilityFormProvider
                                      .assignReferralId(index);

                                  Navigator.of(context).pop();

                                  popUpReferralAddedd(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration({
    required String image,
    BoxFit? fit,
    Alignment? alignment,
    Color? bgColor,
  }) {
    return BoxDecoration(
      color: bgColor ?? Colors.transparent,
      image: DecorationImage(
        alignment: alignment ?? Alignment.bottomCenter,
        image: AssetImage(image),
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}
