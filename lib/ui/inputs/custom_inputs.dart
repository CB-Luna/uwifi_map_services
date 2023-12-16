import 'package:flutter/material.dart';
import 'package:uwifi_map_services/theme/theme_data.dart';

class CustomInputs {
  InputDecoration formInputDecoration({
    String? hint,
    required String label,
    required IconData icon,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
    bool autoSuggest = false,
    Color labelColor = colorPrimary,
    Color hintColor = colorPrimaryLight,
    bool isAvailable = true,
  }) {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        border: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, colorPrimaryLight)),
        enabledBorder: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, colorPrimaryLight)),
        focusedBorder: OutlineInputBorder(
            borderRadius: getBorderRadius(autoSuggest),
            borderSide: getBordeSide(autoSuggest, colorPrimaryDark)),
        fillColor: isAvailable ? colorBgWhite : colorBgLight,
        filled: true,
        hintText: hint,
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: isAvailable ? colorPrimary : colorSecondary,
        ),
        labelStyle: TextStyle(color: isAvailable ? colorPrimary : colorSecondary),
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
