// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uwifi_map_services/classes/channels_see_more.dart';
import 'package:uwifi_map_services/data/constants.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option.dart';
import 'package:uwifi_map_services/ui/views/stepsViews/widgets/tv_popup/layouts/mobile/model/option_channel.dart';
import '../classes/product.dart';
import 'package:uwifi_map_services/classes/premium_channel_packs.dart';
import 'package:uwifi_map_services/classes/video_recording_setbox_lineup.dart';

enum View { planDetails, channelLineup, miniCart }

class TVPopupController extends ChangeNotifier {
  View currentView = View.planDetails;
  late VideoRecordingSetboxLineup viresetline;
  late ChannelsSeeMore channelsSeeMore;
  bool getFees = false;
  int indexContainer = 0;
  int indexContainerChannels = 0;
  int indexPreimumChannelPack = 0;
  bool getAllChannelsSeeMore = false;
  bool getPremiumPackage = false;
  Map<String, List> products = {};
  Map<String, List> videoStreams = {};
  Map<String, List> recordingStorage = {};
  Map<String, List> tvDevices = {};
  Map<String, List> movieBundles = {};
  List<Product> packagePremiumChannels = [];
  List<Product> fees = [];

  List allChannels = [];
  List sportsChannels = [];
  List newsChannels = [];
  List moviesChannels = [];
  List musicChannels = [];
  List kidsChannels = [];

  //Store API responses
  Map<String, PremiumChannelPacks> apiResults = {};
  Map<String, VideoRecordingSetboxLineup> mapViReSetLine = {};

  void init() {
    currentView = View.planDetails;
  }

  void changeView(int id) {
    switch (id) {
      case 0:
        currentView = View.planDetails;
        break;
      case 1:
        currentView = View.channelLineup;
        break;
      case 2:
        currentView = View.miniCart;
        break;
      default:
        currentView = View.planDetails;
        break;
    }
    notifyListeners();
  }

  Future<String> getPremiumChannelPacks(String idTV, String category) async {
    if (apiResults.containsKey(idTV)) {
      return 'Success';
    } else {
      getVideoRecordingSetboxLineup(idTV, category);
      try {
        var url = Uri.parse('$env/planbuilder/api');

        final bodyMsg = jsonEncode({
          "action": "getPremiumChannelsPacks",
        });

        var response = await http.post(url, body: bodyMsg);

        final channels = PremiumChannelPacks.fromJson(response.body);

        if (channels.result.isEmpty) {
          return 'None';
        } else {
          apiResults[idTV] = channels;
          getPremiumPackageChannels(idTV);
          return 'Success';
        }
      } catch (e) {
        print('Exception on PremiumChannelPacks: $e');
        return 'None';
      }
    }
  }

  Future<String> getVideoRecordingSetboxLineup(
      String idTV, String category) async {
    try {
      var url = Uri.parse('$env/planbuilder/api');

      final bodyMsg = jsonEncode({
        "apikey": "svsvs54sef5se4fsv",
        "action": "productBySKU",
        "sku": idTV
      });

      var response = await http.post(url, body: bodyMsg);

      final viresetline = VideoRecordingSetboxLineup.fromJson(response.body);
      if (viresetline.result.identifier.isEmpty) {
        return 'None';
      } else {
        mapViReSetLine[idTV] = viresetline;
        getVideoStreamsandRecordingStorage(idTV);
        getChannelsSeeMore();
        getFeesTV(idTV, category);
        return 'Success Viresetline';
      }
    } catch (e) {
      print('Exception on VideoRecordingSetboxLineup: $e');
      return 'None';
    }
  }

  void getVideoStreamsandRecordingStorage(String idTV) {
    products[idTV] = mapViReSetLine[idTV]!.result.associations.xSell.products;

    for (var i = 0; i < products[idTV]!.length; i++) {
      if (products[idTV]![i].categories.contains("tvVideoStreams")) {
        if (videoStreams.containsKey(idTV)) {
          videoStreams.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        } else {
          videoStreams[idTV] = [];
          videoStreams.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        }
      }
      if (products[idTV]![i].categories.contains("tvRecordingStorage")) {
        if (recordingStorage.containsKey(idTV)) {
          recordingStorage.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        } else {
          recordingStorage[idTV] = [];
          recordingStorage.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        }
      }
      if (products[idTV]![i].categories.contains("tvDevices")) {
        if (tvDevices.containsKey(idTV)) {
          tvDevices.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        } else {
          tvDevices[idTV] = [];
          tvDevices.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        }
      }
      if (products[idTV]![i].categories.contains("MovieBundle")) {
        if (movieBundles.containsKey(idTV)) {
          movieBundles.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        } else {
          movieBundles[idTV] = [];
          movieBundles.update(idTV, (list) {
            list.add(products[idTV]![i]);
            return list;
          });
        }
      }
    }
    // print('Lengh  de video Streams ${videoStreams.length}');
  }

  Future<String> getChannelsSeeMore() async {
    if (getAllChannelsSeeMore == false) {
      try {
        var url = Uri.parse('$env/planbuilder/api');

        final bodyMsg = jsonEncode(
            {"apikey": "svsvs54sef5se4fsv", "action": "channelsLineup"});

        var response = await http.post(url, body: bodyMsg);

        channelsSeeMore = ChannelsSeeMore.fromJson(response.body);

        if (channelsSeeMore.result.isEmpty) {
          return 'None';
        } else {
          for (var i = 0; i < channelsSeeMore.result.length; i++) {
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories
                .contains("ChannelLineup")) {
              allChannels.add(channelsSeeMore.result[i]);
            }
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories.contains("CLSports")) {
              sportsChannels.add(channelsSeeMore.result[i]);
            }
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories.contains("CLNews")) {
              newsChannels.add(channelsSeeMore.result[i]);
            }
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories.contains("CLMovies")) {
              moviesChannels.add(channelsSeeMore.result[i]);
            }
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories.contains("CLMusic")) {
              musicChannels.add(channelsSeeMore.result[i]);
            }
            // ignore: iterable_contains_unrelated_type
            if (channelsSeeMore.result[i].categories.contains("CLKids")) {
              kidsChannels.add(channelsSeeMore.result[i]);
            }
          }
          getAllChannelsSeeMore = true;
          return 'Success Channels SeeMore';
        }
      } catch (e) {
        print('Exception on Channels SeeMore: $e');
        return 'None';
      }
    } else {
      return 'Success Channels SeeMore';
    }
  }

  void getFeesTV(String idTV, String category) {
    if (getFees == false) {
      final localFees = mapViReSetLine[idTV]!.result.associations.fees.products;
      for (var i = 0; i < localFees.length; i++) {
        Product feeTV = Product(
          id: localFees[i].id,
          name: localFees[i].name,
          cost: double.parse(localFees[i].price),
          service: localFees[i].family,
          category: category,
          index: 0,
          isSelected: true,
          quantity: 1,
          pwName: localFees[i].pwName,
        );
        fees.add(feeTV);
      }

      getFees = true;
    }
  }

  void getPremiumPackageChannels(String idTV) {
    if (getPremiumPackage == false) {
      final resultPremiumChannels = apiResults[idTV]!.result;
      for (var i = 0; i < resultPremiumChannels.length; i++) {
        Product premiumChannel = Product(
          id: resultPremiumChannels[i].id,
          name: resultPremiumChannels[i].name,
          cost: double.parse(resultPremiumChannels[i].price),
          service: resultPremiumChannels[i].family,
          category: "tvChannels",
          index: 0,
          isSelected: false,
          quantity: 1,
          pwName: resultPremiumChannels[i].pwName!,
        );
        packagePremiumChannels.add(premiumChannel);
      }
      getPremiumPackage = true;
    }
  }

  List getChannelsAvailableSeeMore(List channels, String idTV) {
    final List channelsAvailable = [];
    for (var i = 0; i < channels.length; i++) {
      if (channels[i].tvChannelLineUp.contains(cleanIDTV(idTV))) {
        channelsAvailable.add(channels[i]);
      }
    }
    return channelsAvailable;
  }

  List getChannelsNotAvailableSeeMore(List channels, String idTV) {
    final List channelsNotAvailable = [];
    for (var i = 0; i < channels.length; i++) {
      if (!channels[i].tvChannelLineUp.contains(cleanIDTV(idTV))) {
        channelsNotAvailable.add(channels[i]);
      }
    }
    return channelsNotAvailable;
  }

  String cleanIDTV(String idTV) {
    return idTV.substring(0, idTV.indexOf('_'));
  }

  void restartIndexTVPopup() {
    indexContainer = 0;
    indexContainerChannels = 0;
    indexPreimumChannelPack = 0;
    notifyListeners();
  }

  void clearCallToAPIs() {
    currentView = View.planDetails;
    apiResults.clear();
    mapViReSetLine.clear();
    products.clear();
    videoStreams.clear();
    tvDevices.clear();
    recordingStorage.clear();
    movieBundles.clear();
    fees.clear();
    packagePremiumChannels.clear();
    getPremiumPackage = false;
    getFees = false;
    getAllChannelsSeeMore = false;
    indexContainer = 0;
    indexContainerChannels = 0;
    indexPreimumChannelPack = 0;
    allChannels.clear();
    sportsChannels.clear();
    newsChannels.clear();
    moviesChannels.clear();
    musicChannels.clear();
    kidsChannels.clear();

    notifyListeners();
  }

  //mobile

  void selectedOptions(int index) {
    for (int i = 0; i < options.length; i++) {
      if (index == i) {
        options[i].isSelected = true;
        indexContainer = index;
      } else {
        options[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  void selectedOptionsChannels(int index) {
    for (int i = 0; i < optionsChannel.length; i++) {
      if (index == i) {
        optionsChannel[i].isSelected = true;
        indexContainerChannels = index;
      } else {
        optionsChannel[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  void selectedChannelPremiumPack(int index) {
    indexPreimumChannelPack = index;
    notifyListeners();
  }

  void showActionSnackBar(BuildContext context, int index) {
    // ignore: prefer_const_constructors
    final snackBar0 = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: const Text(
          "Package's Features",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));
    // ignore: prefer_const_constructors
    final snackBar1 = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: const Text(
          "Click on left card 'movie bundle' to add",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));
    // ignore: prefer_const_constructors
    final snackBar2 = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: const Text(
          'Click on cards to add additional video/recording',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));
    // ignore: prefer_const_constructors
    final snackBar3 = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: const Text(
          "Click on cards to add premium channels",
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));
    // ignore: prefer_const_constructors
    final snackBar4 = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: const Text(
          'Click on button to get set-top box',
          style: TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));

    // ignore: deprecated_member_use
    switch (index) {
      case 0:
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..removeCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(snackBar0);
        notifyListeners();
        break;
      case 1:
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..removeCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(snackBar1);
        notifyListeners();
        break;
      case 2:
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..removeCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(snackBar2);
        notifyListeners();
        break;
      case 3:
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..removeCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(snackBar3);
        notifyListeners();
        break;
      case 4:
        ScaffoldMessenger.of(context)
          // ignore: deprecated_member_use
          ..removeCurrentSnackBar()
          // ignore: deprecated_member_use
          ..showSnackBar(snackBar4);
        notifyListeners();
        break;
    }
  }

  void showChannelSnackBar(BuildContext context, String message) {
    // ignore: prefer_const_constructors
    final snackBarChannel = SnackBar(
        backgroundColor: const Color(0xFF2e5899).withOpacity(0.75),
        content: Text(
          message,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ));

    ScaffoldMessenger.of(context)
      // ignore: deprecated_member_use
      ..removeCurrentSnackBar()
      // ignore: deprecated_member_use
      ..showSnackBar(snackBarChannel);
    notifyListeners();
  }
}
