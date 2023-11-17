import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NumberFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<Map<String, String>> fields = [];

  NumberFormProvider() {
    fields.add({const Uuid().v1(): ''});
    notifyListeners();
  }

  void addField() {
    fields.add({const Uuid().v1(): ''});
    notifyListeners();
  }

  void updateField(String value, int index) {
    final key = fields[index].keys.first;
    fields[index][key] = value;
    notifyListeners();
  }

  void removeField(int index) {
    fields.removeAt(index);
    notifyListeners();
  }
}

// https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code