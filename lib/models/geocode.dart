// To parse this JSON data, do
//
//     final geocode = geocodeFromMap(jsonString);

import 'dart:convert';

class Geocode {
  Geocode({
    required this.items,
  });

  List<Item> items;

  factory Geocode.fromJson(String str) => Geocode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geocode.fromMap(Map<String, dynamic> json) => Geocode(
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class Item {
  Item({
    required this.title,
    required this.id,
    required this.resultType,
    required this.address,
    required this.position,
    required this.mapView,
    required this.scoring,
  });

  String title;
  String id;
  String resultType;
  Address address;
  Position position;
  MapView mapView;
  Scoring scoring;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["id"],
        resultType: json["resultType"],
        address: Address.fromMap(json["address"]),
        position: Position.fromMap(json["position"]),
        mapView: MapView.fromMap(json["mapView"]),
        scoring: Scoring.fromMap(json["scoring"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "id": id,
        "resultType": resultType,
        "address": address.toMap(),
        "position": position.toMap(),
        "mapView": mapView.toMap(),
        "scoring": scoring.toMap(),
      };
}

class Address {
  Address({
    required this.label,
    required this.countryCode,
    required this.countryName,
    required this.stateCode,
    required this.state,
    required this.county,
    required this.city,
    required this.street,
    required this.postalCode,
  });

  String label;
  String countryCode;
  String countryName;
  String stateCode;
  String state;
  String county;
  String city;
  String street;
  String postalCode;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        label: json["label"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        stateCode: json["stateCode"],
        state: json["state"],
        county: json["county"],
        city: json["city"],
        street: json["street"],
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toMap() => {
        "label": label,
        "countryCode": countryCode,
        "countryName": countryName,
        "stateCode": stateCode,
        "state": state,
        "county": county,
        "city": city,
        "street": street,
        "postalCode": postalCode,
      };
}

class MapView {
  MapView({
    required this.west,
    required this.south,
    required this.east,
    required this.north,
  });

  double west;
  double south;
  double east;
  double north;

  factory MapView.fromJson(String str) => MapView.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapView.fromMap(Map<String, dynamic> json) => MapView(
        west: json["west"].toDouble(),
        south: json["south"].toDouble(),
        east: json["east"].toDouble(),
        north: json["north"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "west": west,
        "south": south,
        "east": east,
        "north": north,
      };
}

class Position {
  Position({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Position.fromJson(String str) => Position.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Position.fromMap(Map<String, dynamic> json) => Position(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class Scoring {
  Scoring({
    required this.queryScore,
    required this.fieldScore,
  });

  int queryScore;
  FieldScore fieldScore;

  factory Scoring.fromJson(String str) => Scoring.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Scoring.fromMap(Map<String, dynamic> json) => Scoring(
        queryScore: json["queryScore"],
        fieldScore: FieldScore.fromMap(json["fieldScore"]),
      );

  Map<String, dynamic> toMap() => {
        "queryScore": queryScore,
        "fieldScore": fieldScore.toMap(),
      };
}

class FieldScore {
  FieldScore({
    required this.state,
    required this.city,
    required this.streets,
    required this.postalCode,
  });

  int? state;
  int? city;
  List<int> streets;
  int? postalCode;

  factory FieldScore.fromJson(String str) =>
      FieldScore.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FieldScore.fromMap(Map<String, dynamic> json) => FieldScore(
        state: json["state"],
        city: json["city"],
        streets: List<int>.from(json["streets"].map((x) => x)),
        postalCode: json["postalCode"],
      );

  Map<String, dynamic> toMap() => {
        "state": state,
        "city": city,
        "streets": List<dynamic>.from(streets.map((x) => x)),
        "postalCode": postalCode,
      };
}
