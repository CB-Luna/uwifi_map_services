import 'package:flutter/material.dart';

class CustomInputs {
  InputDecoration formInputDecoration({
    String? hint,
    required String label,
    required IconData icon,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    bool autoSuggest = false,
    Color labelColor = const Color(0xFF8aa7d2),
    Color hintColor = const Color(0xFF8aa7d2),
  }) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        border: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, const Color(0xFF8AA7D2))),
        enabledBorder: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, const Color(0xFF8aa7d2))),
        focusedBorder: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, Colors.blue.shade900)),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: const Color(0xff8990A2),
        ),
        labelStyle: TextStyle(color: labelColor),
        hintStyle: TextStyle(color: hintColor),
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth));
  }

  BorderRadius getBorderRadius(autoSuggest) {
    if (autoSuggest) {
      return const BorderRadius.only(
          topLeft: Radius.circular(22), topRight: Radius.circular(22));
    } else {
      return BorderRadius.circular(50);
    }
  }

  BorderSide getBordeSide(autoSuggest, color) {
    if (autoSuggest) {
      return BorderSide.none;
    } else {
      return BorderSide(color: color);
    }
  }
}
