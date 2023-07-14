import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/gride_view.dart';
import 'package:http/http.dart' as http;

class ACScreen extends StatefulWidget {
  const ACScreen({super.key});
  static const routename = '/ac-screen';
  @override
  State<ACScreen> createState() => _ACScreenState();
}

class _ACScreenState extends State<ACScreen> {
  bool AC = false;
  bool controlwithapp = false;
  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
var getAC = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/26.json');
              var getcheckAC= Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/50.json');
  Future<void> _toggleAC() async {
    await http.patch(url, body: json.encode({'26': AC ? 1 : 0}));
  }
Future<void> _controlACcheck() async {
    await http.patch(url, body: json.encode({'50': controlwithapp ? 0 : 1}));
  }
  bool _isLoading = false;
  Future<void> getToggleValue() async {
   setState(() {
    _isLoading = true;
     
   });
      var acresponse = await http.get(getAC);
    var controlwithappresponse = await http.get(getcheckAC);
    AC = json.decode(acresponse.body) == 1 ? true : false;
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
            'Control Air Conditioning',
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
                            width: 200, child: Image.asset('images/ac.png')),
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
                          _controlACcheck();
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
                                    
                                    Name: "Toggle AC",
                                    boolFan: AC,
                                    onchanged: (value) {
                                      setState(() {
                                        AC = value!;
                                      });
                                      _toggleAC();
                                    },
                                    width:
                                       200,
                                    value: AC,
                                  ),
                                 
                              )
                          : SizedBox(),
                    ],
                  ),
                ),
        ));
  }
}
