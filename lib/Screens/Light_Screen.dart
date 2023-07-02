import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/Profile_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:light_bottom_navigation_bar/light_bottom_navigation_bar.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({super.key});
  static const routename = '/Light';

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  bool value = false;
  bool value2 = false;
  var url = Uri.parse(
      'https://homeautomation-9d333-default-rtdb.firebaseio.com/board1/outputs/digital.json');

  Future<void> _toggleLight() async {
    await http.patch(url, body: json.encode({'27': value ? 1 : 0}));
  }

  Future<void> _toggleLock() async {
    await http.patch(url, body: json.encode({'26': 1}));
    await Future.delayed(const Duration(seconds: 3), () {});
    await http.patch(url, body: json.encode({'26': 0}));
  }

  var screensList = [
    Text('Home'),
    ProfileScreen(),
  ];
  var index = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LightBottomNavigationBar(
        elevation: 10,
        height: 60,
        backgroundColor: Colors.white,
        currentIndex: index,
        items: const [
          LightBottomNavigationBarItem(
              backgroundShadowColor: Color(0xFF493CF1),
              splashColor: Color(0xFF493CF1),
              hoverColor: Color(0xFF493CF1),
              highlightColor: Colors.white,
              borderBottomWidth: 5,
              unSelectedIcon: Icons.home_outlined,
              selectedIcon: Icons.home,
              selectedIconColor: Color(0xFF493CF1),
              unSelectedIconColor: Colors.black54),
          LightBottomNavigationBarItem(
              backgroundShadowColor: Color(0xFF493CF1),
              splashColor: Color(0xFF493CF1),
              hoverColor: Color(0xFF493CF1),
              highlightColor: Colors.white,
              borderBottomWidth: 5,
              unSelectedIcon: Icons.person_outlined,
              selectedIcon: Icons.person,
              selectedIconColor: Color(0xFF493CF1),
              unSelectedIconColor: Colors.black54),
        ],
        onSelected: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
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
      body: index == 0
          ? Center(
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
                                  onTap: () async {
                                    setState(() {
                                      value2 = true;
                                    });
                                    await _toggleLock();

                                    setState(() {
                                      value2 = false;
                                    });
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
                  )),
                  GridTile(
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
            )
          : screensList[index],
    );
  }
}
