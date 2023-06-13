import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation_project/Screens/OTP_Screen.dart';
import 'package:home_automation_project/Screens/new_login.dart';
import './Screens/Login_Screen.dart';
import './Screens/signin.dart';
import './control/cubit/phone_auth.dart';

import 'Screens/Light_Screen.dart';

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
    return BlocProvider(
        create: (BuildContext context) => PhoneAuthCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SignInPage(),
          routes: {
            LoginScreen.routename: (ctx) => LoginScreen(),
            LightScreen.routename: (ctx) => LightScreen(),
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
