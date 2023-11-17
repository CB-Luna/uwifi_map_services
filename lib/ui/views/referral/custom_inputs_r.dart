import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration formInputDecoration(
      {String? hint,
      required String label,
      required IconData icon,
      double maxWidth = double.infinity,
      double maxHeight = double.infinity}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Color(0xFF8aa7d2))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Color(0xFF8aa7d2))),
        fillColor: Colors.white,
        filled: true,
        hintText: hint,
        labelText: label,
        counterText: "",
        prefixIcon: Icon(
          icon,
          color: const Color(0xff8990A2),
        ),
        labelStyle: const TextStyle(color: Color(0xff8990A2)),
        hintStyle: const TextStyle(color: Color(0xff324057)),
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth));
  }
}