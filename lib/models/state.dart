import 'dart:convert';

class States {
  States({
    required this.id,
    required this.name,
    required this.code,
  });

  int id;
  String name;
  String code;

  factory States.fromJson(String str) => States.fromMap(json.decode(str));

  factory States.fromMap(Map<String, dynamic> json) {
    return States(
      id: json['id'] ?? json['state_id'],
      name: json['name'],
      code: json['code'],
    );
  }
}
