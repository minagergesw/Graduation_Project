import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_automation_project/Screens/QR_Scan_Screen.dart';
import 'package:home_automation_project/Screens/QR_Screen.dart';
import 'package:home_automation_project/Screens/signin.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  final TitlesList = [
    'Control your home easily from anywhere',
    'A true smart home experience with advanced technology that facilitates your daily life',
    'Control the lighting, temperature and security devices in your home with a single touch'
  ];

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        3,
        (index) => Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: Container(
                  height: 250,
                  child: Image.asset(
                    'images/${index}.png',
                    fit: BoxFit.fitWidth,
                  )),
            ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 40,
              child: Text(
                'Smart Home',
                style: GoogleFonts.cairo(
                    color: Colors.black54,
                    fontSize: 36,height: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      pages[index],
                      SizedBox(
                        height: 20,
                      ),
                      Container(padding: EdgeInsets.all(3),
                        child: Center(
                          child: Text(
                            TitlesList[index],
                            style: GoogleFonts.cairo(
                                color: Colors.black54,
                                height: 1,
                                 fontSize: 27),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 16,
                dotWidth: 14,
                // type: WormType.thinUnderground,
              ),
            ),SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF493CF1))),
              onPressed: () {
                Navigator.of(context).pushNamed(SignInPage.routename);
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 100,
                child: Text(
                  'Start',
                  style: GoogleFonts.cairo(fontSize: 28,height: 1.4),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
