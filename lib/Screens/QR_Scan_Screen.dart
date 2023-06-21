import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_automation_project/Screens/signin.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

import '../control/cubit/phone_auth.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});
  static const routename = '/QRScanScreen';
  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  bool currentResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRCodeDartScanView(
        scanInvertedQRCode: true,
        onCapture: (Result result) async {
          BlocProvider.of<PhoneAuthCubit>(context).getQrResult(result.text);
          currentResult =
              await BlocProvider.of<PhoneAuthCubit>(context).compareQRResult();

          Navigator.of(context).pop();
          if (currentResult == true) {
            Navigator.of(context).pushNamed(SignInPage.routename);
          }
        },
        // child: Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     margin: EdgeInsets.all(20),
        //     padding: EdgeInsets.all(20),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [

        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
