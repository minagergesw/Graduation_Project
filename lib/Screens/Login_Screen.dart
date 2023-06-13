import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routename = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isloading = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'البيت الذكي',
      //     style: GoogleFonts.tajawal(),
      //   ),
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'المنزل الذكي',
              style: GoogleFonts.tajawal(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'من فضلك قم بادخال كلمة المرور',
              style: GoogleFonts.tajawal(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[800]),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller,
                style: TextStyle(fontSize: 22),
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue[800]),
                child: TextButton(
                    onPressed: () async {
                      setState(() {
                        _isloading = true;
                      });

                      var url = Uri.parse(
                          'https://homeautomation-9d333-default-rtdb.firebaseio.com/pass.json');

                      final response = await http.get(url);
                      if (response.body == _controller.text.toString()) {
                        Navigator.of(context).pushReplacementNamed('/light');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'كلمة المرور غير صحيحة',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.tajawal(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.8),
                            ),
                          ),
                        );
                      }

                      setState(() {
                        _isloading = false;
                      });
                    },
                    child: _isloading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.tajawal(
                                height: 2,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )))
          ]),
        ),
      ),
    );
  }
}
