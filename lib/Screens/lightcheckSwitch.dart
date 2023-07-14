import 'package:flutter/material.dart';

Widget LightCheckSwitch({
  required boolFan,
  required void Function(bool?) onchanged,
  required double width,
  required bool value,
  required String Name,
}) {
  return Container(
      width: width,
      child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(children: [
          SizedBox(
            height: 10,
          ),
          Container(
            // padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              Name,textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    //     Colors.white
                    Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Transform.scale(
              scale: 1.5,
              child: Switch(
                onChanged: onchanged,
                value: value,
              )),
        ]),
      ])));
}
