import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});
  static const routename = '/light';

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool value = false;
  bool value2 = false;
  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');

  Future<void> _toggleLight() async {
    await http.patch(url, body: json.encode({'27': value ? 1: 0}));
  }
 Future<void> _toggleLock() async {
    await http.patch(url, body: json.encode({'26': value2 ? 1 : 0}));

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المنزل الذكي',
          style: GoogleFonts.tajawal(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.8,
              color: Colors.grey[800]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child:
            // Text(
            //   value ? 'الاضاءة تعمل ' : 'الاضاءة لا تعمل',
            //   style: GoogleFonts.tajawal(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,height: 1.8,
            //       color: Colors.grey[800]),
            // ),
            GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
           GridTile(
                child: Column(
              children: [
                Text(
                  'قفل الباب',
                  style: GoogleFonts.tajawal(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                      color: Colors.grey[800]),
                ),
                SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: !value2 ? Colors.green : Colors.red,
                    ),
                    width: 100,
                    height: 100,
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap:
                            () async {
                              setState(() {
                                value2 = !value2;
                              });
                              await _toggleLock();
                            },
                            child: Center(
                              child: Text(
                                value2 ? 'اغلاق' : 'فتح',
                                style: GoogleFonts.tajawal(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.8,
                                    color: Colors.white),
                              ),
                            ))),
                  ),
                ),
              ],
            ))
         , GridTile(
                child: Column(
              children: [
                Text(
                  'الاضاءة',
                  style: GoogleFonts.tajawal(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.8,
                      color: Colors.grey[800]),
                ),
                SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: value ? Colors.green : Colors.red,
                    ),
                    width: 100,
                    height: 100,
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () async {
                              setState(() {
                                value = !value;
                              });
                              await _toggleLight();
                            },
                            child: Center(
                              child: Text(
                                !value ? 'اطفاء' : 'تشغيل',
                                style: GoogleFonts.tajawal(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    height: 1.8,
                                    color: Colors.white),
                              ),
                            ))),
                  ),
                ),
              ],
            )),
             ],
        ),
      ),
    );
  }
}
