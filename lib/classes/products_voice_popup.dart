// To parse this JSON data, do
//
//     final videoRecordingSetboxLineup = videoRecordingSetboxLineupFromMap(jsonString);
import 'dart:convert';

class ProductsVoicePopup {
  ProductsVoicePopup({
    required this.code,
    required this.msg,
    required this.result,
  });

  String code;
  String msg;
  Result result;

  factory ProductsVoicePopup.fromJson(String str) =>
      ProductsVoicePopup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsVoicePopup.fromMap(Map<String, dynamic> json) =>
      ProductsVoicePopup(
        code: json["code"],
        msg: json["msg"],
        result: Result.fromMap(json["result"]),
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "result": result.toMap(),
      };
}

class Result {
  Result({
    required this.identifier,
    required this.enabled,
    required this.family,
    required this.categories,
    required this.groups,
    required this.parent,
    required this.values,
    required this.created,
    required this.updated,
    required this.associations,
  });

  String identifier;
  bool enabled;
  String family;
  List<String> categories;
  List<dynamic> groups; // List<dynamic> To put possible list empty
  dynamic parent;
  Values values;
  DateTime created;
  DateTime updated;
  Associations associations;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        identifier: json["identifier"],
        enabled: json["enabled"],
        family: json["family"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        parent: json["parent"],
        values: Values.fromMap(json["values"]),
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        associations: Associations.fromMap(json["associations"]),
      );

  Map<String, dynamic> toMap() => {
        "identifier": identifier,
        "enabled": enabled,
        "family": family,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "groups": List<dynamic>.from(groups.map((x) =>
            x)), //groups?.isEmpty ?? List<dynamic>.from(groups!.map((x) => x)) To put possible list empty
        "parent": parent,
        "values": values.toMap(),
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "associations": associations.toMap(),
      };
}

class Associations {
  Associations({
    required this.fees,
    required this.pack,
    required this.upsell,
    required this.xSell,
    required this.substitution,
  });

  Content fees;
  Content pack;
  Content upsell;
  Content xSell;
  Content substitution;

  factory Associations.fromJson(String str) =>
      Associations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Associations.fromMap(Map<String, dynamic> json) => Associations(
        fees: Content.fromMap(json["FEES"]),
        pack: Content.fromMap(json["PACK"]),
        upsell: Content.fromMap(json["UPSELL"]),
        xSell: Content.fromMap(json["X_SELL"]),
        substitution: Content.fromMap(json["SUBSTITUTION"]),
      );

  Map<String, dynamic> toMap() => {
        "FEES": fees.toMap(),
        "PACK": pack.toMap(),
        "UPSELL": upsell.toMap(),
        "X_SELL": xSell.toMap(),
        "SUBSTITUTION": substitution.toMap(),
      };
}

class Content {
  Content({
    required this.products,
    required this.productModels,
    required this.groups,
  });

  List<Products> products;
  List<dynamic> productModels;
  List<dynamic> groups;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        products: List<Products>.from(
            json["products"].map((x) => Products.fromMap(x))),
        productModels: List<dynamic>.from(json["product_models"].map((x) => x)),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
        "product_models": List<dynamic>.from(productModels.map((x) => x)),
        "groups": List<dynamic>.from(groups.map((x) => x)),
      };
}

class Products {
  Products({
    required this.id,
    required this.enabled,
    required this.family,
    required this.categories,
    required this.name,
    required this.price,
    required this.picture,
    required this.maxQuantity,
    required this.pwName,
  });

  String id;
  bool enabled;
  String family;
  List<String> categories;
  String name;
  String price;
  String? picture;
  String? maxQuantity;
  String pwName;

  factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["id"],
        enabled: json["enabled"],
        family: json["family"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        name: json["name"],
        price: json["price"],
        picture: json["picture"],
        maxQuantity: json["maxQuantity"],
        pwName: json["pwName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "enabled": enabled,
        "family": family,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "name": name,
        "price": price,
        "picture": picture,
        "maxQuantity": maxQuantity,
        "pwName": pwName,
      };
}

class Values {
  Values({
    required this.networkType,
    required this.customerType,
    required this.locationGroup,
    required this.price,
    required this.name,
    required this.pwName,
    required this.featDesc,
    required this.featTittle,
    required this.description,
  });

  List<CustomerType> networkType;
  List<CustomerType> customerType;
  List<CustomerType> locationGroup;
  List<Price> price;
  List<CustomerType> name;
  List<CustomerType> pwName;
  List<CustomerType> featDesc;
  List<CustomerType> featTittle;
  List<CustomerType> description;

  factory Values.fromJson(String str) => Values.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Values.fromMap(Map<String, dynamic> json) => Values(
        networkType: List<CustomerType>.from(
            json["networkType"].map((x) => CustomerType.fromMap(x))),
        customerType: List<CustomerType>.from(
            json["customerType"].map((x) => CustomerType.fromMap(x))),
        locationGroup: List<CustomerType>.from(
            json["locationGroup"].map((x) => CustomerType.fromMap(x))),
        price: List<Price>.from(json["price"].map((x) => Price.fromMap(x))),
        name: List<CustomerType>.from(
            json["name"].map((x) => CustomerType.fromMap(x))),
        pwName: List<CustomerType>.from(
            json["pwName"].map((x) => CustomerType.fromMap(x))),
        featDesc: List<CustomerType>.from(
            json["featDesc"].map((x) => CustomerType.fromMap(x))),
        featTittle: List<CustomerType>.from(
            json["featTittle"].map((x) => CustomerType.fromMap(x))),
        description: List<CustomerType>.from(
            json["description"].map((x) => CustomerType.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "networkType": List<dynamic>.from(networkType.map((x) => x.toMap())),
        "customerType": List<dynamic>.from(customerType.map((x) => x.toMap())),
        "locationGroup":
            List<dynamic>.from(locationGroup.map((x) => x.toMap())),
        "price": List<dynamic>.from(price.map((x) => x.toMap())),
        "name": List<dynamic>.from(name.map((x) => x.toMap())),
        "pwName": List<dynamic>.from(pwName.map((x) => x.toMap())),
        "featDesc": List<dynamic>.from(featDesc.map((x) => x.toMap())),
        "featTittle": List<dynamic>.from(featTittle.map((x) => x.toMap())),
        "description": List<dynamic>.from(description.map((x) => x.toMap())),
      };
}

class CustomerType {
  CustomerType({
    required this.locale,
    required this.scope,
    required this.data,
    required this.links,
  });

  String? locale;
  String? scope;
  String data;
  Links? links;

  factory CustomerType.fromJson(String str) =>
      CustomerType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerType.fromMap(Map<String, dynamic> json) => CustomerType(
        locale: json["locale"],
        scope: json["scope"],
        data: json["data"],
        links: json["_links"] == null ? null : Links.fromMap(json["_links"]),
      );

  Map<String, dynamic> toMap() => {
        "locale": locale,
        "scope": scope,
        "data": data,
        "_links": links ?? links?.toMap(),
      };
}

class Links {
  Links({
    required this.download,
  });

  Download download;

  factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        download: Download.fromMap(json["download"]),
      );

  Map<String, dynamic> toMap() => {
        "download": download.toMap(),
      };
}

class Download {
  Download({
    required this.href,
  });

  String href;

  factory Download.fromJson(String str) => Download.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Download.fromMap(Map<String, dynamic> json) => Download(
        href: json["href"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
      };
}

class Price {
  Price({
    required this.locale,
    required this.scope,
    required this.data,
  });

  dynamic locale;
  dynamic scope;
  List<Datum> data;

  factory Price.fromJson(String str) => Price.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Price.fromMap(Map<String, dynamic> json) => Price(
        locale: json["locale"],
        scope: json["scope"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "locale": locale,
        "scope": scope,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.amount,
    required this.currency,
  });

  String amount;
  String currency;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        amount: json["amount"],
        currency: json["currency"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "currency": currency,
      };
}
