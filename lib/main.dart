import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation_project/Light/Light_Screen.dart';
import 'package:home_automation_project/Screens/AC_Screen.dart';
import 'package:home_automation_project/Screens/Fan_Screen.dart';
import 'package:home_automation_project/Screens/Home_Screen.dart';
import 'package:home_automation_project/Screens/QR_Scan_Screen.dart';
import 'package:home_automation_project/Screens/QR_Screen.dart';
import 'package:home_automation_project/Screens/Security_Screen.dart';
import 'package:home_automation_project/Screens/Welcome_Screen.dart';
import 'package:home_automation_project/Screens/signUp.dart';
import 'package:home_automation_project/Screens/signin.dart';
import './Screens/Login_Screen.dart';
import './control/cubit/phone_auth.dart';

import 'Screens/Light_Screen.dart';
import 'control/cubit/authCubit.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, phoneNumber});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PhoneAuthCubit>(
          create: (BuildContext context) => PhoneAuthCubit(),
        ),
        BlocProvider<RoleAuthCubit>(
          create: (BuildContext context) => RoleAuthCubit()..checkAdmin(),
        )
      ],
       
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return MaterialApp(
              theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xFF493CF1)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              debugShowCheckedModeBanner: false,
              // home: SignInPage(),
              home: snapshot.hasData ? HomeScreen() : WelcomeScreen(),
              routes: {
                LoginScreen.routename: (ctx) => LoginScreen(),
                // LightScreen.routename: (ctx) => LightScreen(),
                HomeScreen.routename: (ctx) => HomeScreen(),
                QRScreen.routename: (ctx) => QRScreen(),
                QRScanScreen.routename: (ctx) => QRScanScreen(),
                SignInPage.routename: (ctx) => SignInPage(),
                SignUpPage.routename: (ctx) => SignUpPage(),
                LightScreen.routename: (ctx) => LightScreen(),
                FanScreen.routename: (ctx) => FanScreen(),
                ACScreen.routename: (ctx) => ACScreen(),
                SecurityScreen.routename: (ctx) => SecurityScreen(),
              },
            );
          },
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
