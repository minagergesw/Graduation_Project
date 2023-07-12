import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../widgets/gride_view.dart';

class GasScreen extends StatefulWidget {
  const GasScreen({super.key});
  static const routename = '/fan-screen';
  @override
  State<GasScreen> createState() => _GasScreenState();
}

class _GasScreenState extends State<GasScreen> {
  bool fan = false;

  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var url2 = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/30.json');

  // control gas
  Future<void> _controlgas() async {
    await http.patch(url, body: json.encode({'30': fan ? 1 : 0}));
  }
  // control gas hood

  Future<void> _controlgasHood() async {
    await http.patch(url, body: json.encode({'30': fan ? 1 : 0}));
  }
  // //control gas alarm

  Future<void> _controlgasAlarm() async {
    await http.patch(url, body: json.encode({'30': fan ? 1 : 0}));
  }

  bool _isLoading = false;
  Future<void> getToggleValue() async {
    setState(() {
      _isLoading = true;
    });
    var response = await http.get(url2);
    fan = json.decode(response.body) == 1 ? true : false;
    setState(() {
      _isLoading = false;
    });
    print(response.body);
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
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: double.infinity,
                          height: 800,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              containerControlGas(
                                ImagePath: "images/kitchen.png",
                                Name: "Gas Hood",
                                boolFan: fan,
                                onchanged: (value) {
                                  setState(() {
                                    fan = value!;
                                    print(fan);
                                  });
                                  _controlgasHood();
                                  print(fan);
                                },
                                width: MediaQuery.of(context).size.width / 2,
                                value: fan,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              containerControlGas(
                                ImagePath: "images/water-pipe.png",
                                Name: "Control gas",
                                boolFan: fan,
                                onchanged: (value) {
                                  setState(() {
                                    fan = value!;
                                    print(fan);
                                  });
                                  _controlgas();
                                  print(fan);
                                },
                                width: MediaQuery.of(context).size.width / 2,
                                value: fan,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              containerControlGas(
                                ImagePath: "images/fire-sensor.png",
                                Name: "Gas alarm",
                                boolFan: fan,
                                onchanged: (value) {
                                  setState(() {
                                    fan = value!;
                                    print(fan);
                                  });
                                  _controlgasAlarm();
                                  print(fan);
                                },
                                width: MediaQuery.of(context).size.width / 2,
                                value: fan,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
        ));
  }
}
