import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uwifi_map_services/classes/product.dart';
import 'package:uwifi_map_services/providers/cart_controller.dart';
import 'package:uwifi_map_services/providers/tv_popup_controller.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_additional_recording.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_additional_video.dart';
import 'package:uwifi_map_services/ui/buttons/custom_card_aditional_recording_empty.dart';

class AdditionalTabs extends StatelessWidget {
  final String idTV;
  const AdditionalTabs({Key? key, required this.idTV}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<Cart>(context);
    final tvpopupController = Provider.of<TVPopupController>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final bool mobile = size.width <= 880 ? true : false;
    final style = GoogleFonts.workSans(
      fontSize: 11,
      color: const Color(0xFF2e5899),
      fontWeight: FontWeight.bold,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Add additional:",
          style: GoogleFonts.workSans(
            height: 1.5,
            fontSize: 16,
            color: const Color(0xFF101E51),
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border : Border.all(color: mobile ? const Color(0xff8AA7D2) : Colors.white)
          ),
          child: DefaultTabController(
            length: 2,
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
                              Tab(child: Text("Video Streams", style: style)),
                              Tab(child: Text("Recording Storage", style: style)),
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
                          children:
                            List.generate(tvpopupController.videoStreams[idTV]!.length,(index){
                              String name = tvpopupController.videoStreams[idTV]![index].name;
                              double cost = double.parse(tvpopupController.videoStreams[idTV]![index].price);
                              Product additional = Product(
                                id: tvpopupController.videoStreams[idTV]![index].id, 
                                name: name, 
                                cost: cost, 
                                service: tvpopupController.videoStreams[idTV]![index].family, 
                                category: tvpopupController.videoStreams[idTV]![index].categories[0], 
                                index: index,
                                isSelected: false,
                                quantity: 1, 
                                pwName: tvpopupController.videoStreams[idTV]![index].pwName);
                              // ignore: iterable_contains_unrelated_type
                              if (!cartController.additionalsVideo.contains((element) => element.index == index)) {
                                cartController.additionalsVideo.add(additional);
                              }
                              // print(additional);
                              return CustomCardAdditionalVideo(index: index, name: name, cost: cost);
                            })
                          ,
                        ),
                      ),
                        Center(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 5,
                          runSpacing: 5,
                          children: tvpopupController.recordingStorage.containsKey(idTV) ?
                          List.generate(tvpopupController.recordingStorage[idTV]!.length,(index){
                              String name = tvpopupController.recordingStorage[idTV]![index].name;
                              double cost = double.parse(tvpopupController.recordingStorage[idTV]![index].price);
                              Product additional = Product(
                                id: tvpopupController.recordingStorage[idTV]![index].id, 
                                name: name, 
                                cost: cost, 
                                service: tvpopupController.recordingStorage[idTV]![index].family, 
                                category: tvpopupController.recordingStorage[idTV]![index].categories[0], 
                                index: index,
                                isSelected: false,
                                quantity: 1, 
                                pwName: tvpopupController.recordingStorage[idTV]![index].pwName);
                              // ignore: iterable_contains_unrelated_type
                              if (!cartController.additionalsRecording.contains((element) => element.index == index)) {
                                  cartController.additionalsRecording.add(additional);
                                }
                              return  CustomCardAdditionalRecording(index: index, name: name, cost: cost);
                            }) 
                            :
                            [const CustomCardAdditionalRecordingEmpty()],
                            
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
