import 'package:flutter/material.dart';
import 'package:home_automation_project/Screens/Profile_Screen.dart';
class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProfileScreen.routename);
          },
          child: ClipRRect(borderRadius: BorderRadius.circular(24),
            child: CircleAvatar(
                radius: 24,
                child: Image.asset('images/images.jpg')),
          ),
        );
  }
}