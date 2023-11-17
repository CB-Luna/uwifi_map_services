import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_movie_bundle.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_movie_bundle_coming_soon.dart';

class TVPopupMovieChannelsBundle extends StatelessWidget {
  final String idTV;
  const TVPopupMovieChannelsBundle({Key? key, required this.idTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final tvPopupController = Provider.of<TVPopupController>(context);
    final movieBundles = tvPopupController.movieBundles;
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width <= 880 ? true : false;
    final style = GoogleFonts.workSans(
      fontSize: 11,
      color: const Color(0xFF2e5899),
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Text(
          "You can also get:",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 16,
            color: mobile ? const Color(0xFF2E5899) : const Color(0xFF101E51),
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border : Border.all(color: mobile ? const Color(0xff8AA7D2) : Colors.white)
          ),
          child: DefaultTabController(
            length: 1,
            child: Column(
              children: [
                SizedBox(
                    height: 40,
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TabBar(
                            indicator: BoxDecoration(
                                color: const Color(0xFFd20030).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border : Border.all(color: const Color(0xFFd20030), width: 2)),
                            tabs: [
                              Tab(child: Text("Movie Bundle One", style: style)),
                            ]))),
                const Divider(
                  thickness: 2,
                  color: Color(0xFF8AA7D2),
                ),
                SizedBox(
                    height: 80,
                    child: TabBarView(children: [
                      Center(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          runSpacing: 5,
                          children: List.generate(movieBundles[idTV]!.length, (index) {
                            String id = movieBundles[idTV]![index].id;
                            String name = movieBundles[idTV]![index].name;
                            double cost = double.parse(movieBundles[idTV]![index].price);
                            String image = movieBundles[idTV]![index].picture;
                            List<String> groups = movieBundles[idTV]![index].groups;
                            Product movieBundle = Product(
                                id: id,
                                name: name,
                                cost: cost,
                                service: movieBundles[idTV]![index].family,
                                category: "gigFastTV",
                                index: index,
                                isSelected: false,
                                quantity: 1,
                                pwName: movieBundles[idTV]![index].pwName,
                                groups: groups);
                            cartController.moviesbundle.add(movieBundle);
                            return groups.contains('comingSoon') ?
                            CustomCardMovieBundleComingSoon(
                              index: index, 
                              name: name, 
                              image: image, 
                              cost: cost)
                            :
                            CustomCardMovieBundle(
                              index: index,
                              name: name,
                              image: image,
                              cost: cost,
                            );
                          }),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
