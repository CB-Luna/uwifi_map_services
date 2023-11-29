import 'dart:convert';

class Plan {
  String id;
  String planCategory;
  String? name;
  String? featTitle;
  String? description;
  String? featDesc;
  double? price;
  bool isEnabled;
  bool isSelected;
  String? pwName;
  bool? isComing;
  Associations? associations;

  Plan(
    this.id,
    this.planCategory,
    this.name,
    this.featTitle,
    this.description,
    this.featDesc,
    this.price,
    this.isEnabled,
    this.isSelected,
    this.pwName,
    this.isComing,
    this.associations,
  );

  Plan copyWith({
    String? id,
    String? planCategory,
    String? name,
    String? featTitle,
    String? description,
    String? featDesc,
    double? price,
    bool? isEnabled,
    bool? isSelected,
    String? pwName,
    bool? isComing,
    Associations? associations,
  }) {
    return Plan(
      id ?? this.id,
      planCategory ?? this.planCategory,
      name ?? this.name,
      featTitle ?? this.featTitle,
      description ?? this.description,
      featDesc ?? this.featDesc,
      price ?? this.price,
      isEnabled ?? this.isEnabled,
      isSelected ?? this.isSelected,
      pwName ?? this.pwName,
      isComing ?? this.isComing,
      associations ?? this.associations,
    );
  }
}

class Associations {
  Associations({
    required this.pack,
  });

  Pack? pack;

  factory Associations.fromJson(String str) =>
      Associations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Associations.fromMap(Map<String, dynamic> json) => Associations(
        pack: json["PACK"] == null ? null : Pack.fromMap(json["PACK"]),
      );

  Map<String, dynamic> toMap() => {
        "PACK": pack == null ? null : pack!.toMap(),
      };
}

class Pack {
  Pack({
    required this.products,
  });

  List<Products>? products;

  factory Pack.fromJson(String str) => Pack.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pack.fromMap(Map<String, dynamic> json) => Pack(
        products: json["products"] == null
            ? null
            : List<Products>.from(
                json["products"].map((x) => Products.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toMap())),
      };
}

class Products {
  Products({
    this.id,
    this.enabled,
    this.description,
    this.family,
    this.categories,
    this.name,
    this.price,
    this.pwName,
    this.groups,
    this.isActive,
    this.descriptionPic,
  });

  String? id;
  bool? enabled;
  String? description;
  String? family;
  List<dynamic>? categories;
  String? name;
  String? price;
  String? pwName;
  List<dynamic>? groups;
  bool? isActive;
  String? descriptionPic;

  Products copyWith(
      {String? id,
      bool? enabled,
      String? description,
      String? family,
      List<dynamic>? categories,
      String? name,
      String? price,
      String? pwName,
      List<dynamic>? groups,
      bool? isActive,
      String? descriptionPic}) {
    return Products(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      description: description ?? this.description,
      family: family ?? this.family,
      categories: categories ?? this.categories,
      name: name ?? this.name,
      price: price ?? this.price,
      pwName: pwName ?? this.pwName,
      groups: groups ?? this.groups,
      isActive: isActive ?? this.isActive,
      descriptionPic: descriptionPic ?? this.descriptionPic,
    );
  }

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
      id: json["id"],
      enabled: json["enabled"],
      description: json["description"],
      family: json["family"],
      categories: List<dynamic>.from(json["categories"].map((x) => x)),
      name: json["name"],
      price: json["price"],
      pwName: json["pwName"],
      groups: json["groups"] == null
          ? null
          : List<dynamic>.from(json["groups"].map((x) => x)),
      isActive: false,
      descriptionPic: json["picture"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "enabled": enabled,
        "description": description,
        "family": family,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x)),
        "name": name,
        "price": price,
        "pwName": pwName,
        "picture": descriptionPic,
        "groups": groups == null
            ? null
            : List<dynamic>.from(
                groups!.map((x) => x),
              ),
      };
}

class PromoGroup {
  String id;
  bool isActive;
  String? name;
  String? infoPicture;
  List<Products> promos;

  PromoGroup(this.id, this.isActive, this.name, this.infoPicture, this.promos);

  PromoGroup copyWith(
      {String? id,
      bool? isActive,
      String? name,
      String? infoPicture,
      List<Products>? promos}) {
    return PromoGroup(
        id ?? this.id,
        isActive ?? this.isActive,
        name ?? this.name,
        infoPicture ?? this.infoPicture,
        promos ?? this.promos);
  }
}
