import 'package:flutter/material.dart';

Widget containerControlGas(
    {required boolFan,
    required void Function(bool?) onchanged,
    required double width,
    required bool value,
    required String Name,
    String? ImagePath}) {
  return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(24),
        color: boolFan ? null : Color.fromARGB(67, 157, 102, 240),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // icon
            ImagePath == null
                ? SizedBox()
                : Image.asset(
                    ImagePath,
                    height: 65,
                  ),

            // smart device name + switch
            Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                // padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  Name,
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
