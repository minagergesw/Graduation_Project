import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems(
      {required this.title,
      required this.icon,
      required this.onpress,
      required this.endIcon,
      this.textcolor});
  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child: Icon(
          icon,
          color: Color.fromARGB(255, 72, 32, 203),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: textcolor),
      ),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                LineAwesomeIcons.angle_right,
                size: 20,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
