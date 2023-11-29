import 'package:flutter/material.dart';
import 'package:uwifi_map_services/models/domain/place.dart';
import 'package:uwifi_map_services/providers/search_controller_portability.dart';

class CustomListTilePortability extends StatelessWidget {
  final Place place;
  final SearchControllerPortability controller;
  const CustomListTilePortability({
    Key? key,
    required this.place,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Regular Expression Syntax:
    // ^      Matches the start of a line
    // $      Matches the end of a line
    // [0-9]+ Match one or more digits. The brackets match one of the items in
    //        the range and + is a wildcard meaning one or more matches.
    //        Instead of [0-9] you can also use \d
    // .*     Match zero or more characters. The . matches any single character
    //        and * is a wildcard to match zero or more ocurrences of whatever
    //        character precedes it.
    // [^.]   Match any single character except for any of the characters that
    //        come after the ^. Do not confuse [^] with ^
    // \w     Match any single alphanumeric character => [0-9a-zA-Z] and _
    // \s     Match any whitespace character
    // ?      Use to optional character ? after any character to specify zero or
    //        one ocurrence of that character. Thus, you would use .? to match
    //        any single character optionally
    // a|b    Matches a or b
    // \      Use to escape any especial characters ([, ], ., etc.)
    // ()     capture groups surrounding them in parenthesis (to use in code)

    // Code Example:
    // final line = '[00:12.30]Twinkle, twinkle little star';
    // final regex1 = RegExp(r'^\[([0-9]+):([0-9]+)\.([0-9]+)\](.*)$');
    // final match = regex1.firstMatch(line);
    // final everything = match?.group(0);  // [00:12.30]Twinkle, twinkle little star
    // final minutes = match?.group(1);     // 00
    // final seconds = match?.group(2);     // 12
    // final fraction = match?.group(3);    // 30
    // final words = match?.group(4);       // Twinkle, twinkle little star

    //Source: https://medium.com/flutter-community/extracting-text-from-a-string-with-regex-groups-in-dart-b6be604c8a69

    //Extract street number
    final RegExp regex = RegExp(r'^([0-9]+)(\s+.*)?$');
    final RegExpMatch? match = regex.firstMatch(controller.streetPort);
    final String streetNumberPort = match?.group(1) ?? '';

    return ListTile(
      leading: const Icon(
        Icons.location_on_outlined,
        color: Color(0xFFff3a3a),
      ),
      title: streetNumberPort != ''
          ? Text('$streetNumberPort ${place.address}')
          : Text(place.address),
      onTap: () {
        controller.pickPlacePortability(place, streetNumberPort);
        controller.clearPlaces();
      },
      hoverColor: Colors.grey[200],
    );
  }
}
