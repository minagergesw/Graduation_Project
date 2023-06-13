import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/Colors.dart';
import '../control/cubit/phone_auth.dart';
import '../control/status/phone_auth_status.dart';
import 'OTP_Screen.dart';

@override
class Login2Screen extends StatelessWidget {
  Login2Screen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  late String phoneNumber;
  PhoneAuthCubit? phoneAuthCubit;

  Widget _buildIntroTexts() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            " Welcom to Your home system",
            style: TextStyle(
                fontSize: 23,
                color: MyColors.blackColor,
                fontWeight: FontWeight.bold),
          )),
          SizedBox(
            height: 40,
          ),
          Text(
            " What is your name?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: nameController,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                if (value!.isEmpty) {
                  return " Please Enter your name";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'What is your phone number?',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              //  height: 20,
              ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              'Please enter yout phone number to verify your account.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFormField() {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.lightGrey),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Text(
                generateCountryFlag() + ' +20',
                style: TextStyle(fontSize: 18, letterSpacing: 2.0),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.blue),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: TextFormField(
                autofocus: true,
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2.0,
                ),
                decoration: InputDecoration(border: InputBorder.none),
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter yout phone number!';
                  } else if (value.length < 11) {
                    return 'Too short for a phone number!';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);

          _register(context);
        },
        child: Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(110, 50),
          primary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpScreen(phoneNumber: phoneNumber)));
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _phoneFormKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroTexts(),
                  SizedBox(
                    height: 80,
                  ),
                  _buildPhoneFormField(),
                  SizedBox(
                    height: 70,
                  ),
                  _buildNextButton(context),
                  _buildPhoneNumberSubmitedBloc(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
