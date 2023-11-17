// To parse this JSON data, do
//
//     final premiumChannelPacks = premiumChannelPacksFromMap(jsonString);

import 'dart:convert';

class PremiumChannelPacks {
  PremiumChannelPacks({
    required this.code,
    required this.msg,
    required this.result,
  });

  String code;
  String msg;
  List<Result> result;

  factory PremiumChannelPacks.fromJson(String str) =>
      PremiumChannelPacks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PremiumChannelPacks.fromMap(Map<String, dynamic> json) =>
      PremiumChannelPacks(
        code: json["code"],
        msg: json["msg"],
        result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "result": List<dynamic>.from(result.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.id,
    required this.enabled,
    required this.family,
    required this.categories,
    required this.name,
    required this.price,
    required this.picture,
    required this.packItems,
    required this.pwName,
    required this.groups,
  });

  String id;
  bool enabled;
  String family;
  List<Category> categories;
  String name;
  String price;
  String picture;
  List<PackItem> packItems;
  String? pwName;
  List<String> groups;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        enabled: json["enabled"],
        family: json["family"],
        categories: List<Category>.from(
            json["categories"].map((x) => categoryValues.map[x])),
        name: json["name"],
        price: json["price"],
        picture: json["picture"],
        packItems: List<PackItem>.from(
            json["packItems"].map((x) => PackItem.fromMap(x))),
        pwName: json["pwName"] ?? '',
        groups: List<String>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "enabled": enabled,
        "family": family,
        "categories": List<dynamic>.from(
            categories.map((x) => categoryValues.reverse[x])),
        "name": name,
        "price": price,
        "picture": picture,
        "packItems": List<dynamic>.from(packItems.map((x) => x.toMap())),
        "pwName": pwName,
        "groups": List<dynamic>.from(groups.map((x) => x)),
      };
}

enum Category { premiumChannelPacks, clSports, channelLineup }

final categoryValues = EnumValues({
  "ChannelLineup": Category.channelLineup,
  "CLSports": Category.clSports,
  "PremiumChannelsPacks": Category.premiumChannelPacks
});

class PackItem {
  PackItem({
    required this.id,
    required this.enabled,
    required this.family,
    required this.categories,
    required this.name,
    required this.picture,
    required this.groups,
  });

  String id;
  bool enabled;
  Family? family;
  List<Category> categories;
  String name;
  String picture;
  List<String> groups;

  factory PackItem.fromJson(String str) => PackItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PackItem.fromMap(Map<String, dynamic> json) => PackItem(
        id: json["id"],
        enabled: json["enabled"],
        family: familyValues.map[json["family"]],
        categories: List<Category>.from(
            json["categories"].map((x) => categoryValues.map[x])),
        name: json["name"],
        picture: json["picture"],
        groups: List<String>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "enabled": enabled,
        "family": familyValues.reverse[family],
        "categories": List<dynamic>.from(
            categories.map((x) => categoryValues.reverse[x])),
        "name": name,
        "picture": picture,
        "groups": List<dynamic>.from(groups.map((x) => x)),
      };
}

enum Family { tvChannels }

final familyValues = EnumValues({"TVChannels": Family.tvChannels});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
