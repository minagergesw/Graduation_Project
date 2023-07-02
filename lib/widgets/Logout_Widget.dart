import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF493CF1)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
              Radius.circular(20.0) //                 <--- border radius here
              ),
        ),
        // padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        child: Row(
          children: [
            Container(
                width: 8,
                child: Icon(
                  size: 20,
                  Icons.logout_rounded,
                )),
            Container(
              padding: EdgeInsets.only(right: 2, top: 2, bottom:8),
              width: 70,
              child: Text(
                'تسجيل الخروج',
                style: GoogleFonts.almarai(fontSize: 12, height: 1.3),
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
    // ClipRRect(
    //   borderRadius: BorderRadius.circular(20),
    //   child: Material(
    //       child: InkWell(
    //     onTap: () {},
    //     child: Container(
    //       decoration: BoxDecoration(color: Color.fromARGB(255, 226, 234, 244),

    //         borderRadius: BorderRadius.all(
    //             Radius.circular(20.0) //                 <--- border radius here
    //             ),
    //       ),
    //       padding: EdgeInsets.all(5),
    //       alignment: Alignment.center,
    //       child: Row(
    //         children: [
    //           Container(
    //               width: 30,
    //               child: Icon(
    //                 Icons.logout_rounded,
    //               )),
    //           Container(
    //             padding: EdgeInsets.only(right: 8, top: 4, bottom: 6),
    //             width: 70,
    //             child: Text(
    //               'تسجيل الخروج',
    //               style: GoogleFonts.almarai(fontSize: 20, height: 1),
    //               textDirection: TextDirection.rtl,
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   )
    //       // color: Color(0xFF9787BB),
    //       ),
    // );
  }
}
