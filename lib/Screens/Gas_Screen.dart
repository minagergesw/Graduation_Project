import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import './gride_view.dart';

class GasScreen extends StatefulWidget {
  const GasScreen({super.key});
  static const routename = '/gas-screen';
  @override
  State<GasScreen> createState() => _GasScreenState();
}

class _GasScreenState extends State<GasScreen> {
  bool gas = false;
  bool gasfan = false;
  bool alarm = false;
  bool controlwithapp = false;

  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var getgasfan = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/5.json');
  var getcheckgas = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/52.json');
  var getalarm = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/14.json');
  // control gas
  Future<void> _controlgasfan() async {
    await http.patch(url, body: json.encode({'5': gasfan ? 1 : 0}));
  }
  // //control gas alarm

  Future<void> _controlgasAlarm() async {
    await http.patch(url, body: json.encode({'14': alarm ? 1 : 0}));
  }

  Future<void> _controlgascheck() async {
    await http.patch(url, body: json.encode({'52': controlwithapp ? 0 : 1}));
  }

  bool _isLoading = false;
  Future<void> getToggleValue() async {
    setState(() {
      _isLoading = true;
    });
    var responsegasfan = await http.get(getgasfan);
    var responsecheckgas = await http.get(getcheckgas);
    var responsealarm = await http.get(getalarm);
    gasfan = json.decode(responsegasfan.body) == 1 ? true : false;
    controlwithapp = json.decode(responsecheckgas.body) == 1 ? false : true;
    alarm = json.decode(responsealarm.body) == 1 ? true : false;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getToggleValue();
    super.initState();
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF493CF1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Control gas',
            style: GoogleFonts.cairo(height: 1, fontSize: 24),
          ),
        ),
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 240,
                        alignment: Alignment.center,
                        child: Container(
                            width: 200, child: Image.asset('images/gas.png')),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      containerControlGas(
                        // ImagePath: "images/valve.png",
                        Name: "Control with App",
                        boolFan: controlwithapp,
                        onchanged: (value) {
                          setState(() {
                            controlwithapp = value!;
                          });
                          _controlgascheck();
                        },
                        width: 200,
                        value: controlwithapp,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      controlwithapp == true
                          ? Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  containerControlGas(
                                    ImagePath: "images/valve.png",
                                    Name: "Control gas",
                                    boolFan: gasfan,
                                    onchanged: (value) {
                                      setState(() {
                                        gasfan = value!;
                                      });
                                      _controlgasfan();
                                    },
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    value: gasfan,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  containerControlGas(
                                    ImagePath: "images/alert.png",
                                    Name: "Gas Alarm",
                                    boolFan: alarm,
                                    onchanged: (value) {
                                      setState(() {
                                        alarm = value!;
                                        print(alarm);
                                      });
                                      _controlgasAlarm();
                                      print(alarm);
                                    },
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    value: alarm,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
        ));
  }
}
