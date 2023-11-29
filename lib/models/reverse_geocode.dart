// To parse this JSON data, do
//
//     final reverseGeocode = reverseGeocodeFromMap(jsonString);

import 'dart:convert';

class ReverseGeocode {
    ReverseGeocode({
        required this.items,
    });

    List<Item> items;

    factory ReverseGeocode.fromJson(String str) => ReverseGeocode.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ReverseGeocode.fromMap(Map<String, dynamic> json) => ReverseGeocode(
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
        required this.houseNumberType,
        required this.address,
        required this.position,
        required this.access,
        required this.distance,
        required this.mapView,
    });

    String title;
    String id;
    String resultType;
    String houseNumberType;
    Address address;
    Position position;
    List<Position> access;
    int distance;
    MapView mapView;

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        title: json["title"],
        id: json["id"],
        resultType: json["resultType"],
        houseNumberType: json["houseNumberType"],
        address: Address.fromMap(json["address"]),
        position: Position.fromMap(json["position"]),
        access: List<Position>.from(json["access"].map((x) => Position.fromMap(x))),
        distance: json["distance"],
        mapView: MapView.fromMap(json["mapView"]),
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "id": id,
        "resultType": resultType,
        "houseNumberType": houseNumberType,
        "address": address.toMap(),
        "position": position.toMap(),
        "access": List<dynamic>.from(access.map((x) => x.toMap())),
        "distance": distance,
        "mapView": mapView.toMap(),
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

class Address {
    Address({
        required this.label,
        required this.countryCode,
        required this.countryName,
        required this.state,
        required this.county,
        required this.city,
        required this.street,
        required this.postalCode,
        required this.houseNumber,
    });

    String label;
    String countryCode;
    String countryName;
    String state;
    String county;
    String city;
    String street;
    String postalCode;
    String houseNumber;

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Address.fromMap(Map<String, dynamic> json) => Address(
        label: json["label"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        state: json["state"],
        county: json["county"],
        city: json["city"],
        street: json["street"],
        postalCode: json["postalCode"],
        houseNumber: json["houseNumber"],
    );

    Map<String, dynamic> toMap() => {
        "label": label,
        "countryCode": countryCode,
        "countryName": countryName,
        "state": state,
        "county": county,
        "city": city,
        "street": street,
        "postalCode": postalCode,
        "houseNumber": houseNumber,
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
