import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_automation_project/Screens/gride_view.dart';
import 'package:home_automation_project/Screens/lightcheckSwitch.dart';
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
  bool _isindoor = false;
  bool _isoutdoor = false;
  bool controlwithapp = false;
  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var getindoor = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/15.json');
  var getoutdoor = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/19.json');
  var getcheckoutdoor = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/51.json');
  Future<void> _toggleindoorLight() async {
    await http.patch(url, body: json.encode({'15': _isindoor ? 1 : 0}));
  }

  Future<void> _toggleoutdoorLight() async {
    await http.patch(url, body: json.encode({'19': _isoutdoor ? 1 : 0}));
  }

  Future<void> _controllightcheck() async {
    await http.patch(url, body: json.encode({'51': controlwithapp ? 0 : 1}));
  }

  bool _isLoading = false;
  Future<void> getToggleValue() async {
    setState(() {
      _isLoading = true;
    });
    var indoorResponse = await http.get(getindoor);
    var outdoorResponse = await http.get(getoutdoor);
    var checkResponse = await http.get(getcheckoutdoor);
    _isindoor = json.decode(indoorResponse.body) == 1 ? true : false;
    _isoutdoor = json.decode(outdoorResponse.body) == 1 ? true : false;
    controlwithapp = json.decode(checkResponse.body) == 1 ? false : true;
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                  screenWidth: screenWidth * 0.9,
                  screenHeight: screenWidth,
                  color: darkGray,
                  roomName: " Indoor light",
                ),
                controlwithapp
                    ? LampSwitch(
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
                      )
                    : Container(),
                controlwithapp
                    ? LampSwitchRope(
                        screenWidth: screenWidth * 0.8,
                        screenHeight: screenHeight,
                        color: darkGray,
                        isSwitchOn: _isoutdoor,
                        animationDuration: animationDuration,
                      )
                    : Container(),
                controlwithapp
                    ? RoomName(
                        screenWidth: screenWidth * 1.2,
                        screenHeight: screenWidth,
                        color: darkGray,
                        roomName: " Outdoor light",
                      )
                    : Container(),

                Positioned(top: 130,right: 20,
                  child: LightCheckSwitch(
                    // ImagePath: "images/valve.png",
                    Name: "Control with App",
                    boolFan: controlwithapp,
                    onchanged: (value) {
                      setState(() {
                        controlwithapp = value!;
                      });
                      _controllightcheck();
                    },
                    width: 120,
                    
                    value: controlwithapp,
                  ),
                )
              ],
            ),
    );
  }
}
