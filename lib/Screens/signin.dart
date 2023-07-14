import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Light/Light_Screen.dart';
import 'package:home_automation_project/Screens/Home_Screen.dart';
import 'package:home_automation_project/Screens/QR_Screen.dart';
import 'package:home_automation_project/Screens/signUp.dart';
import '../control/cubit/authCubit.dart';
import '../control/status/authState.dart';
import '../widgets/home.dart';
import '../widgets/settings.dart';
import 'Light_Screen.dart';
import '../Screens/resetPassword.dart';

class SignInPage extends StatefulWidget {
  static const routename = '/signin';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future<void> _signIn() async {
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();

  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // User signed in successfully
  //     print("User signed in with email: $email");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => LightScreen()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     } else {
  //       print(e.message);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RoleAuthCubit, RoleAuthStates>(
            listener: (context, state) {
      if (state is SignInAsAdminSuccess) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Welcome back, Admin!'),
          duration: Duration(seconds: 10),
          backgroundColor: Color.fromARGB(255, 88, 7, 169),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
      }

      if (state is SignInAsUserSuccess) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Welcome back, ${FirebaseAuth.instance.currentUser!.displayName}!'),
          duration: Duration(seconds: 5),
          backgroundColor: Color.fromARGB(255, 98, 33, 209),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
      }
    }, builder: (context, state) {
      return SafeArea(
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
                    'Smart Home',
                    style: GoogleFonts.cairo(
                        fontSize: 30,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.start,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: GoogleFonts.cairo(
                        height: 1,
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
                        return "please enter a valid email";
                      }
                      if (!value.contains('@')) {
                        return "please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    textAlign: TextAlign.start,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: GoogleFonts.cairo(fontSize: 12, height: 1),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
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
                          BlocProvider.of<RoleAuthCubit>(context).UserSignIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF493CF1)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.cairo(
                              fontSize: 20,
                              height: 1.3,
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
                              .pushReplacementNamed(QRScreen.routename);
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
                          "Create New Account",
                          style: GoogleFonts.cairo(
                              fontSize: 20,height: 1.3,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF493CF1)),
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ResetPasswordPage()));
                  //     },
                  //     child: Text(
                  //       "هل نسيت كلمة السر ؟",
                  //       style: GoogleFonts.almarai(
                  //           fontSize: 16, color: Color(0xFF493CF1)),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}
