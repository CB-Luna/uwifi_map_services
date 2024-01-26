import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class ExtrasSection extends StatelessWidget {
  const ExtrasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    
    return SizedBox(
      height: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.11,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/fresh_merch.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.34,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Imagenes de arriba
                Row(
                  children: [
                    //Imagen del Logo
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/image_u-wifi.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Accesorios
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          height: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://nsrprlygqaqgljpfggjh.supabase.co/storage/v1/object/public/assets/internet_accesories.png?t=2024-01-09T19%3A33%3A27.960Z"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //Carrousel
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: cartController.merchant.length > 2 ?  0.4 : 0.6,
                          autoPlay: true,
                        ),
                        items: cartController.merchant.map((merchantItem) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cartController.addToCart(merchantItem.id);
                                    },
                                    child: Container(
                                      width: 135,
                                      height: 135,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(merchantItem.imageurl),
                                          fit: BoxFit.fill,
                                          ),
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11.29),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                  merchantItem.name,
                                    style: const TextStyle(
                                    color: colorBgDark,
                                    fontSize: 14.0,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    "\$${merchantItem.cost}",
                                    style: const TextStyle(
                                    color: colorBorder,
                                    fontSize: 15.9,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

