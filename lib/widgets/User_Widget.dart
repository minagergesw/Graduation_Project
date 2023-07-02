import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return 
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Row(
                  children: [
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ' ! ' + 'مرحبا مينا',
                          style: GoogleFonts.almarai(fontSize: 28),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'التاريخ : ' +
                                DateTime.now().day.toString() +
                                '/' +
                                DateTime.now().month.toString() +
                                '/' +
                                DateTime.now().year.toString(),
                            style: GoogleFonts.almarai(fontSize: 15),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
           
        );
  }
}
