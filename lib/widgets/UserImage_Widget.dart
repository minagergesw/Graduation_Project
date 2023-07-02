import 'package:flutter/material.dart';
class UserImageWidget extends StatelessWidget {
  const UserImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {},
          child: CircleAvatar(
              radius: 24,
              child: Image.asset('images/user.png')),
        );
  }
}