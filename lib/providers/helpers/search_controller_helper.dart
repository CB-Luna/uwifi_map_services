// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:google_maps/google_maps.dart';

class SearchControllerHelper {
  late final MapOptions mapOptions;
  late final GMap map;
  late final Marker marker;
  late final DivElement elem;
  LatLng initialLocation = LatLng(29.461145, -94.645017);
  final infoWindow = InfoWindow(InfoWindowOptions()..content = '');

  SearchControllerHelper() {
    mapOptions = MapOptions()
      ..zoom = 15
      ..fullscreenControl = false
      ..center = initialLocation;

    elem = DivElement()
      ..id = 'map'
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    map = GMap(elem, mapOptions);

    marker = Marker(
      MarkerOptions()
        ..position = initialLocation
        ..map = map
        ..title = 'This is your location'
        ..draggable = true
        ..icon = '/assets/images/you-pointer.png',
    );
  }
}
