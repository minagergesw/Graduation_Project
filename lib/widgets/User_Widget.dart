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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                           'Hello Mina'+" !",
                          style: GoogleFonts.cairo(fontSize: 28,height: 1),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Date : ' +
                                DateTime.now().day.toString() +
                                '/' +
                                DateTime.now().month.toString() +
                                '/' +
                                DateTime.now().year.toString(),
                            style: GoogleFonts.cairo(fontSize: 15,height: 1),
                            textDirection: TextDirection.ltr
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
