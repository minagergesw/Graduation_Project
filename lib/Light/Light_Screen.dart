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
  var _isindoor = false;
  var _isoutdoor = false;

  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var url2 = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/28.json');
  var url3 = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/27.json');
  Future<void> _toggleindoorLight() async {
    await http.patch(url, body: json.encode({'28': _isindoor ? 1 : 0}));
  }

  Future<void> _toggleoutdoorLight() async {
    await http.patch(url, body: json.encode({'27': _isoutdoor ? 1 : 0}));
  }
   bool _isLoading = false;
  Future<void> getToggleValue() async {
   setState(() {
    _isLoading = true;
     
   });
    var response1 = await http.get(url2);
    var response2 = await http.get(url3);
    _isindoor = json.decode(response1.body) == 1 ? true : false;
    _isoutdoor = json.decode(response2.body) == 1 ? true : false;
   setState(() {
     
    _isLoading = false;
   });
    // print(response.body);
  }
@override
  void initState() {
    getToggleValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body:_isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  Stack(
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
                        isSwitchOn: _isindoor || _isoutdoor,
                        color: Colors.transparent,
                      ),
                      Lamp(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        color: darkGray,
                        isSwitchOn: _isindoor || _isoutdoor,
                        gradientColor: bulbOnColor,
                        animationDuration: animationDuration,
                      ),

                      /////
                      LampSwitch(
                        screenWidth: screenWidth * 0.9,
                        screenHeight: screenHeight,
                        toggleOnColor: bulbOnColor,
                        toggleOffColor: bulbOffColor,
                        color: darkGray,
                        isSwitchOn: _isindoor,
                        onTap: () {
                          setState(() {
                            _isindoor = !_isindoor;
                            _toggleindoorLight();
                          });
                        },
                        animationDuration: animationDuration,
                      ),
                      LampSwitchRope(
                        screenWidth: screenWidth * 1.1,
                        screenHeight: screenHeight,
                        color: darkGray,
                        isSwitchOn: _isindoor,
                        animationDuration: animationDuration,
                      ),
                      RoomName(
                        screenWidth: screenWidth * 1.2,
                        screenHeight: screenWidth,
                        color: darkGray,
                        roomName: " Indoor light",
                      ),
                      LampSwitch(
                        screenWidth: screenWidth * 1.2,
                        screenHeight: screenHeight,
                        toggleOnColor: bulbOnColor,
                        toggleOffColor: bulbOffColor,
                        color: darkGray,
                        isSwitchOn: _isoutdoor,
                        onTap: () {
                          setState(() {
                            _isoutdoor = !_isoutdoor;
                            _toggleoutdoorLight();
                          });
                        },
                        animationDuration: animationDuration,
                      ),
                      LampSwitchRope(
                        screenWidth: screenWidth * 0.8,
                        screenHeight: screenHeight,
                        color: darkGray,
                        isSwitchOn: _isoutdoor,
                        animationDuration: animationDuration,
                      ),
                      RoomName(
                        screenWidth: screenWidth * 0.9,
                        screenHeight: screenWidth,
                        color: darkGray,
                        roomName: " Outdoor light",
                      ),
                    ],
                  ),
    );
  }
}
