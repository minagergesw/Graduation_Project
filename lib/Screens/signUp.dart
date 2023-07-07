import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/Home_Screen.dart';
import 'package:home_automation_project/control/cubit/authCubit.dart';
import 'package:home_automation_project/control/status/authState.dart';
import 'package:home_automation_project/widgets/home.dart';
import 'package:home_automation_project/widgets/settings.dart';

import '../Screens/signin.dart';

class SignUpPage extends StatefulWidget {
  static const routename = '/signup';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    
    return
             BlocConsumer<RoleAuthCubit, RoleAuthStates>(
              listener: (context, state) {
               if (state is SuccessAdminAuth) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Welcome to your home !'),
                    duration: Duration(seconds: 5),
                    backgroundColor: Color.fromARGB(255, 88, 7, 169),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ));
                }

                if (state is SuccessUserAuth) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Welcome to your home!'),
                    duration: Duration(seconds: 10),
                    backgroundColor: Color.fromARGB(255, 88, 7, 169),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ));
                }
           
              },
              builder: (context, state) {
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
                                height: 70,
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
                              SizedBox(height: 16.0),
                              TextFormField(
                                textAlign: TextAlign.end,
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: " الاسم",
                                  hintStyle: GoogleFonts.tajawal(
                                    fontSize: 12,
                                  ),
                                ),
                                // obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your name";
                                  }
                                  
                                  return null;
                                },
                              ),
                              SizedBox(height: 30.0),
                              Visibility(
                                visible: BlocProvider.of<RoleAuthCubit>(context)
                                    .isvisible,
                                child: Center(
                                  child: Container(
                                    height: 60,
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<RoleAuthCubit>(context,listen: false)
                                            .signUpAsAdmin(
                                                email: _emailController
                                                    .text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                                namee: _nameController.text
                                                    .trim());
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF493CF1)),
                                        shape: MaterialStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                      ),
                                      child: Text(
                                        " Register as Admin",
                                        style: GoogleFonts.abel(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Container(
                                  height: 60,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<RoleAuthCubit>(context,listen: false)
                                          .signUpAsUser(
                                              email:
                                                  _emailController.text.trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                              namee:
                                                  _nameController.text.trim());
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF493CF1)),
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                    ),
                                    child: Text(
                                      " Register as user ",
                                      style: GoogleFonts.abel(
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
                                  height: 80,
                                  width: 200,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              SignInPage.routename);
                                    },
                                    style: ButtonStyle(
                                      elevation:
                                          MaterialStateProperty.all<double>(0),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
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
              },
            );
          
          
        
  }
}
