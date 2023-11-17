import 'dart:convert';

class ChannelsSeeMore {
  ChannelsSeeMore({
    required this.code,
    required this.msg,
    required this.result,
  });

  String code;
  String msg;
  List<Result> result;

  factory ChannelsSeeMore.fromJson(String str) =>
      ChannelsSeeMore.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChannelsSeeMore.fromMap(Map<String, dynamic> json) => ChannelsSeeMore(
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
    required this.picture,
    required this.tvChannelLineUp,
    required this.description,
  });

  String id;
  bool enabled;
  Family? family;
  List<String> categories;
  String name;
  String? picture;
  String? tvChannelLineUp;
  String? description;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        enabled: json["enabled"],
        family: familyValues.map[json["family"]],
        categories: List<String>.from(json["categories"].map((x) => x)),
        name: json["name"],
        picture: json["picture"],
        tvChannelLineUp: json["tvChannelLineUp"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "enabled": enabled,
        "family": familyValues.reverse[family],
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "name": name,
        "picture": picture,
        "tvChannelLineUp": tvChannelLineUp,
        "description": description,
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
