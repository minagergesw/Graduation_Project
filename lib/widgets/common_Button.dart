import 'package:flutter/material.dart';

Widget commonButton({required VoidCallback onpressed, required String text}) {
  return ElevatedButton(
    onPressed: onpressed,
    child: Text(
      text,
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 78, 39, 176),
      side: BorderSide.none,
      shape: StadiumBorder(),
    ),
  );
}
