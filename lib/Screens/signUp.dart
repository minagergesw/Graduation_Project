import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Light_Screen.dart';
import '../Screens/signin.dart';
import '../constants/Colors.dart';

class SignUpPage extends StatefulWidget {
  static const routename = '/signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed up successfully
      print("User signed up with email: $email");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LightScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150,
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
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.end,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "الايميل",
                      hintStyle: GoogleFonts.tajawal(
                        fontSize: 13,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.tajawal(
                      height: 1,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email address";
                      }
                      if (!value.contains('@')) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    textAlign: TextAlign.end,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "كلمة السر",
                      hintStyle: GoogleFonts.tajawal(
                        fontSize: 12,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: Container(
                      height: 60,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          _signUp();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF493CF1)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        child: Text(
                          "انشاء حساب",
                          style: GoogleFonts.almarai(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                 SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                      height: 60,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignInPage.routename);
                        },
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        child: Text(
                          "لديك حساب بالفعل ؟",
                          style: GoogleFonts.almarai(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF493CF1)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
