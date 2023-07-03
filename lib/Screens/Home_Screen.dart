import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Light/Light_Screen.dart';
import 'package:home_automation_project/Screens/Profile_Screen.dart';
import 'package:home_automation_project/control/cubit/phone_auth.dart';
import 'package:home_automation_project/widgets/Logout_Widget.dart';
import 'package:home_automation_project/widgets/UserImage_Widget.dart';
import 'package:home_automation_project/widgets/User_Widget.dart';
import 'package:light_bottom_navigation_bar/light_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

// import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routename = '/Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isloading = false;
  @override
  void initState() {
    
    
    getData();

    super.initState();
  }
var data ={};
  Stream<Object> getData() async* {
    _isloading = true;
    var url = Uri.parse(
        'https://homeautomation-9d333-default-rtdb.firebaseio.com/readings.json');
    var response = await http.get(url);

    print(json.decode(response.body));
    data = json.decode(response.body);
    _isloading = false;
    
    yield response;
  }

  var screensList = [
    Text('Home'),
    ProfileScreen(),
  ];
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: getData(),
      builder: (context, snapshot) {

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
          body: snapshot.connectionState==ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // SizedBox(),
                              UserWidget(),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  // LogoutWidget(),
                                  // SizedBox(),
                                      UserImageWidget(),
                                  // SizedBox(),
                                ]),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(0xFF493CF1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // height: 170,
                              width: double.infinity,
                              child: Column(children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 30, left: 20),
                                              child: Text(
                                                'Temperature',
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    height: 1),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child: Text(
                                                '${data["temperature"]} °C',
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                    height: 1),
                                              )),
                                        ],
                                      ),
                                      Container(
                                        width: 120,
                                        height: 120,
                                        padding: EdgeInsets.all(20),
                                        child: Image.asset('images/cloudy.png'),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 20, top: 5, bottom: 5),
                                          child: Text(
                                            'Humidity : ${data["humidity"]} %',
                                            style: GoogleFonts.cairo(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1),
                                          )),
                                      Container(
                                          padding: EdgeInsets.only(
                                              right: 20, top: 5, bottom: 5),
                                          child: Text(
                                            'Fahrenheit : ${data["fahrenheit"]} °F',
                                            style: GoogleFonts.cairo(
                                                color: Colors.white,
                                                fontSize: 16,
                                                height: 1),
                                          )),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromARGB(255, 160, 77, 0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // height: 170,
                              width: double.infinity,
                              child: Column(children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 20),
                                              child: Text(
                                                'Gas Record',
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    height: 1),
                                              )),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child: Text(
                                                '${data["gas"]}',
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                    height: 1),
                                              )),
                                        ],
                                      ),
                                      Container(
                                        width: 120,
                                        height: 120,
                                        padding: EdgeInsets.all(20),
                                        child: Image.asset('images/gas.png'),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(LightScreen.routename);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        width: 150.0,
                                        height: 150.0,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 90,
                                                child:
                                                    Image.asset('images/bulb.png'),
                                              ),
                                              Container(
                                                child: Text(
                                                  'Light',
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    color: Color.fromARGB(255, 54, 45, 190),
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(LightScreen.routename);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        width: 150.0,
                                        height: 150.0,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 90,
                                                child:
                                                    Image.asset('images/fan.png'),
                                              ),
                                              Container(
                                                child: Text(
                                                  'Fan',
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.white,
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      height: 1),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    color: Color.fromARGB(255, 54, 45, 190),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
        );
      }
    );
  }
}
