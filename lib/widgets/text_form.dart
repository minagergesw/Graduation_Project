import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textForm(
    {required String hintText,
    required String textForValidation,
    required TextEditingController controller}) {
  return TextFormField(
    textAlignVertical: TextAlignVertical.center,
    textAlign: TextAlign.left,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.abel(
        fontSize: 13,
      ),
    ),
    keyboardType: TextInputType.emailAddress,
    textInputAction: TextInputAction.next,
    style: GoogleFonts.abel(
      height: 1,
      fontSize: 16,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your ${textForValidation}";
      } else {
        return null;
      }
    },
  );
}
