// To parse this JSON data, do
//
//     final coverageValidate = coverageValidateFromMap(jsonString);

import 'dart:convert';

class CoverageValidate {
  CoverageValidate({
    required this.code,
    required this.msg,
    required this.result,
  });

  String code;
  String msg;
  Result result;

  factory CoverageValidate.fromJson(String str) =>
      CoverageValidate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoverageValidate.fromMap(Map<String, dynamic> json) =>
      CoverageValidate(
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
    required this.coverage,
    required this.type,
    required this.msg,
    required this.locationgroup,
    required this.flow,
  });

  bool coverage;
  String? type;
  String? msg;
  String? locationgroup;
  String? flow;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        coverage: json["coverage"],
        type: json["type"],
        msg: json["msg"],
        locationgroup: json["locationgroup"],
        flow: json["flow"],
      );

  Map<String, dynamic> toMap() =>
      {"coverage": coverage, "type": type, "locationgroup": locationgroup};
}
