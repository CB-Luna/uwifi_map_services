import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/providers/plan_controller.dart';

import '../../../../providers/remote/boxes_behavior_controller.dart';
import 'promo_details_popup.dart';
import 'promo_switcher.dart';

class PromosListBox extends StatelessWidget {
  const PromosListBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planController = Provider.of<PlanController>(context);
    var promosGroups = planController.promoGroups;

    final listBehavior = Provider.of<BoxesBehavior>(context);

    final scrollController = ScrollController();

    final size = MediaQuery.of(context).size;
    final bool mobile = size.width < 950 ? true : false;

    return listBehavior.isPromosListVisible
        ? Visibility(
            visible: listBehavior.isPromosListVisible,
            child: AnimatedContainer(
              clipBehavior: Clip.antiAlias,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              width: 300,
              margin: EdgeInsets.fromLTRB(mobile ? 25 : 25, 25, 25, 25),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: -5,
                  color: Color(0x506FA5DB),
                  offset: Offset(0, 15),
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Column(children: [
                Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF2e5899),
                        image: DecorationImage(
                          alignment: Alignment.center,
                          opacity: 0.75,
                          image: AssetImage('images/bg_gradient.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 30),
                        Text("Available Promos",
                            style: GoogleFonts.workSans(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.50)),
                        ClayContainer(
                          spread: 3,
                          color: Colors.white,
                          parentColor: const Color(0xff2e5899),
                          height: 35,
                          width: 35,
                          depth: 30,
                          borderRadius: 25,
                          curveType: CurveType.concave,
                          child: Transform.scale(
                            scaleX: -1,
                            child: IconButton(
                              icon: const Icon(
                                Icons.keyboard_tab_rounded,
                                color: Color(0xff2e5899),
                                size: 18,
                              ),
                              onPressed: () {
                                listBehavior.changePromosListVisibility();
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20.0),
                    child: promosGroups.isEmpty
                        ? Text(
                            'Sorry. Seems like there is no promos available for this area.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                                fontSize: 16,
                                color: const Color(0xFF2e5899),
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.50))
                        : ListView.builder(
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: promosGroups.length,
                            itemBuilder: (_, int index) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff2e5899)
                                          .withOpacity(0.3)),
                                  // color: const Color.fromARGB(255, 121, 172, 239)
                                  //     .withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              barrierColor:
                                                  const Color(0x00022963)
                                                      .withOpacity(0.40),
                                              context: context,
                                              builder: (_) {
                                                return PromoDetailsPopup(
                                                    promoName:
                                                        promosGroups[index]
                                                            .name!,
                                                    promoDescription:
                                                        promosGroups[index]
                                                            .infoPicture);
                                              });
                                        },
                                        icon: Icon(Icons.info_outline_rounded,
                                            size: 20,
                                            color: const Color(0xff2e5899)
                                                .withOpacity(0.5))),
                                    Expanded(
                                      child: Text(
                                        promosGroups[index].name!,
                                        style: GoogleFonts.workSans(
                                            fontSize: mobile ? 12 : 14,
                                            color: const Color(0xFF2e5899),
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.5),
                                      ),
                                    ),
                                    PromosSwitcher(
                                      promoGroup: promosGroups[index],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                )),
              ]),
            ),
          )
        : Visibility(
            visible: !listBehavior.isPromosListVisible,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClayContainer(
                spread: 6,
                color: const Color(0xff2e5899),
                parentColor: const Color(0xffdfedff),
                height: 45,
                width: 45,
                depth: 40,
                borderRadius: 25,
                curveType: CurveType.concave,
                child: GestureDetector(
                  onTap: () {
                    listBehavior.changePromosListVisibility();
                  },
                  child: const Icon(
                    Icons.sell_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          );
  }
}
