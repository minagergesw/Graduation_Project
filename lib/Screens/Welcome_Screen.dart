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
    'تحكم فى منزلك بسهولة من اى مكان',
    'تجربة منزل ذكي حقيقية مع تقنية متقدمة تسهل حياتك اليومية',
    'تحكم في الإضاءة ودرجة الحرارة وأجهزة الأمان في منزلك بلمسة واحدة'
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
                'المنزل الذكي',
                style: GoogleFonts.almarai(
                    color: Colors.black54,
                    fontSize: 36,
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
                      Container(
                        child: Center(
                          child: Text(
                            TitlesList[index],
                            style: GoogleFonts.almarai(
                                color: Colors.black54, fontSize: 28),
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
                  'ابدأ',
                  style: GoogleFonts.almarai(fontSize: 28),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
