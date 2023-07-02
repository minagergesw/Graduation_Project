import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/widgets/Logout_Widget.dart';
import 'package:home_automation_project/widgets/UserImage_Widget.dart';
import 'package:home_automation_project/widgets/User_Widget.dart';
import 'package:weather_animation/weather_animation.dart';
// import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routename = '/Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        UserImageWidget(),
                        SizedBox(
                          width: 6,
                        ),
                        // LogoutWidget(),
                        // SizedBox(),
                        UserWidget(),
                        // SizedBox(),
                      ]),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFFfdfbef),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 170,
                    width: double.infinity,
                    child: Column(children: [
                      Text('24°C'),
                      Divider(),
                      Container(width: 70,
                          child:WeatherScene.sunset.getWeather()),
                      Row(
                        children: [],
                      )
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
