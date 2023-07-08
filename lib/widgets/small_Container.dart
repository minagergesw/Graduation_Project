import 'package:flutter/material.dart';

Widget smallContainer() {
  return Container(
    margin: const EdgeInsets.only(top: 10, bottom: 20),
    width: 50,
    height: 5,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 64, 39, 176),
        borderRadius: BorderRadius.circular(30)),
  );
}
