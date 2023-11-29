import 'dart:convert';

class Welcome {
  Welcome({
    required this.code,
    required this.msg,
    this.resultTrue,
    this.resultFalse,
  });

  String code;
  String msg;
  List<ResultTrue>? resultTrue;
  ResultFalse? resultFalse;

  factory Welcome.fromJson(String str) => Welcome.fromMap(json.decode(str));

  factory Welcome.fromMap(Map<String, dynamic> json) => Welcome(
        code: json["code"],
        msg: json["msg"],
        resultTrue: json["code"] == "0"
            ? List<ResultTrue>.from(
                json["result"].map((x) => ResultTrue.fromMap(x)))
            : [],
        resultFalse:
            json["code"] == "1" ? ResultFalse.fromMap(json["result"]) : null,
      );
}

class ResultTrue {
  ResultTrue({
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.email,
  });

  String? customerId;
  String? firstName;
  String? lastName;
  String? street;
  String? city;
  String? state;
  String? zipcode;
  String? email;

  factory ResultTrue.fromJson(String str) =>
      ResultTrue.fromMap(json.decode(str));

  factory ResultTrue.fromMap(Map<String, dynamic> json) => ResultTrue(
        customerId: json["customerID"] ?? "NONE",
        firstName: json["firstName"] ?? "NONE",
        lastName: json["lastName"] ?? "NONE",
        street: json["street"] ?? "NONE",
        city: json["city"] ?? "NONE",
        state: json["state"] ?? "NONE",
        zipcode: json["zipcode"] ?? "NONE",
        email: json["email"] ?? "NONE",
      );
}

class ResultFalse {
  ResultFalse({
    required this.siteid,
    required this.phone,
    required this.location,
  });

  String? siteid;
  String? phone;
  String? location;

  factory ResultFalse.fromJson(String str) =>
      ResultFalse.fromMap(json.decode(str));

  factory ResultFalse.fromMap(Map<String, dynamic> json) => ResultFalse(
        siteid: json["siteid"] ?? "NONE",
        phone: json["phone"] ?? "NONE",
        location: json["location"] ?? "NONE",
      );
}
