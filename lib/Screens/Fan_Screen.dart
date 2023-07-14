import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/gride_view.dart';
import 'package:http/http.dart' as http;

class FanScreen extends StatefulWidget {
  const FanScreen({super.key});
  static const routename = '/fan-screen';
  @override
  State<FanScreen> createState() => _FanScreenState();
}

class _FanScreenState extends State<FanScreen> {
  bool fan = false;
  bool controlwithapp = false;
  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var getfan = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/4.json');
        var getcheckfan= Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/50.json');
  Future<void> _toggleFan() async {
    await http.patch(url, body: json.encode({'4': fan ? 1 : 0}));
  }
Future<void> _controlfancheck() async {
    await http.patch(url, body: json.encode({'50': controlwithapp ? 0 : 1}));
  }
  bool _isLoading = false;
  Future<void> getToggleValue() async {
   setState(() {
    _isLoading = true;
     
   });
    var fanresponse = await http.get(getfan);
    var controlwithappresponse = await http.get(getcheckfan);
    fan = json.decode(fanresponse.body) == 1 ? true : false;
    controlwithapp = json.decode(controlwithappresponse.body) == 1 ? false : true;
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
            'Control Fan',
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
                            width: 200, child: Image.asset('images/fan.png')),
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
                          _controlfancheck();
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
                              child:
                                  containerControlGas(
                                    
                                    Name: "Toggle Fan",
                                    boolFan: fan,
                                    onchanged: (value) {
                                      setState(() {
                                        fan = value!;
                                      });
                                      _toggleFan();
                                    },
                                    width:
                                       200,
                                    value: fan,
                                  ),
                                 
                              )
                          : SizedBox(),
                    ],
                  ),
                ),
        ));
 }
}
