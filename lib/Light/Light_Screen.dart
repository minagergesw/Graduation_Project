import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LEDBulb.dart';
import 'LampSwitchRope.dart';
import 'lamp.dart';
import 'lamp_Switch.dart';
import 'lamp_hunger.dart';
import 'room_name.dart';

final darkGray = const Color(0xFF232323);
final bulbOnColor = Color.fromARGB(255, 44, 143, 255);
final bulbOffColor = const Color(0xFFC1C1C1);
final animationDuration = const Duration(milliseconds: 500);

class LightScreen extends StatefulWidget {
  static const routename = '/light-screen';
  @override
  _LightScreenState createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  var _isSwitchOn = false;

  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');

  Future<void> _toggleLight() async {
    await http.patch(url, body: json.encode({'27': _isSwitchOn ? 1 : 0}));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(        extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          
          LampHangerRope(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              color: darkGray),
          LEDBulb(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            onColor: bulbOnColor,
            offColor: bulbOffColor,
            isSwitchOn: _isSwitchOn,
            color: Colors.transparent,
          ),
          Lamp(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            gradientColor: bulbOnColor,
            animationDuration: animationDuration,
          ),
          LampSwitch(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            toggleOnColor: bulbOnColor,
            toggleOffColor: bulbOffColor,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            onTap: () {
              setState(() {
                _isSwitchOn = !_isSwitchOn;
                _toggleLight();
              });
            },
            animationDuration: animationDuration,
          ),
          LampSwitchRope(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            color: darkGray,
            isSwitchOn: _isSwitchOn,
            animationDuration: animationDuration,
          ),
          RoomName(
            screenWidth: screenWidth,
            screenHeight: screenWidth,
            color: darkGray,
            roomName: " Toggele light",
          ),
        ],
      ),
    );
  }
}
