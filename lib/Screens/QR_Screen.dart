import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/QR_Scan_Screen.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});
  static const routename = '/QRScreen';

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'QR Scan',
                  style: GoogleFonts.almarai(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'To start using the application, please click on the word Scan and use the phone\'s camera to scan the code on the device that looks like the following image',
                  style: GoogleFonts.cairo(fontSize: 18,height: 1.5),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 270,
                    width: 220,
                    child: Image.asset('images/smarthome.png')),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: 210,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF493CF1))),
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(QRScanScreen.routename);
                      },
                      child: Text(
                        'Scan QR Code',
                        style: GoogleFonts.cairo(fontSize: 18,height: 1.4,fontWeight: FontWeight.bold),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
