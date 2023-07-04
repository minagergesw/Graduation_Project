import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FanScreen extends StatefulWidget {
  const FanScreen({super.key});
  static const routename = '/fan-screen';
  @override
  State<FanScreen> createState() => _FanScreenState();
}

class _FanScreenState extends State<FanScreen> {
  bool fan = false;

  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');
  var url2 = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital/30.json');
  Future<void> _toggleFan() async {
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
          'Toggle Fan',
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
                      height: 300,
                      alignment: Alignment.center,
                      child: Container(
                          width: 250, child: Image.asset('images/fan.png')),
                    ),
                    Transform.scale(
                        scale: 2,
                        child: Switch(
                          onChanged: (value) {
                            setState(() {
                              fan = value;
                              print(fan);
                            });
                            _toggleFan();
                            print(fan);
                          },
                          value: fan,
                        )),
                  ],
                ),
              ),
      ),
    );
  }
}
