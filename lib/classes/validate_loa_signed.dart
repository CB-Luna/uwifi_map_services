import 'dart:convert';

class ValidateLOASigned {
    ValidateLOASigned({
        required this.code,
        required this.msg,
        required this.result,
    });

    int code;
    String msg;
    bool result;

    factory ValidateLOASigned.fromJson(String str) => ValidateLOASigned.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ValidateLOASigned.fromMap(Map<String, dynamic> json) => ValidateLOASigned(
        code: json["code"],
        msg: json["msg"],
        result: json["result"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "result": result,
    };
}
