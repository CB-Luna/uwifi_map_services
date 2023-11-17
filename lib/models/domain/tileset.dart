// To parse this JSON data, do
//
//     final tileset = tilesetFromMap(jsonString);
import 'dart:convert';

class Tileset {
  Tileset({
    required this.type,
    required this.features,
  });

  String type;
  List<Feature> features;

  factory Tileset.fromJson(String str) {
    return Tileset.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  factory Tileset.fromMap(Map<String, dynamic> json) => Tileset(
        type: json["type"],
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
      };
}

class Feature {
  Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
  });

  String type;
  int id;
  Geometry geometry;
  Properties properties;

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromMap(json["geometry"]),
        properties: Properties.fromMap(json["properties"]),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "geometry": geometry.toMap(),
        "properties": properties.toMap(),
      };
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  Properties({
    this.name,
    required this.tilequery,
  });

  String? name;
  Tilequery tilequery;

  factory Properties.fromJson(String str) =>
      Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        name: json["Name"],
        tilequery: Tilequery.fromMap(json["tilequery"]),
      );

  Map<String, dynamic> toMap() => {
        "Name": name,
        "tilequery": tilequery.toMap(),
      };
}

class Tilequery {
  Tilequery({
    required this.distance,
    required this.geometry,
    required this.layer,
  });

  double distance;
  String geometry;
  String layer;

  factory Tilequery.fromJson(String str) => Tilequery.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tilequery.fromMap(Map<String, dynamic> json) => Tilequery(
        distance: json["distance"].toDouble(),
        geometry: json["geometry"],
        layer: json["layer"],
      );

  Map<String, dynamic> toMap() => {
        "distance": distance,
        "geometry": geometry,
        "layer": layer,
      };
}
