import 'package:flutter/material.dart';

class RoomName extends StatelessWidget {
  final double screenWidth, screenHeight;
  final Color color;
  final String roomName;

  const RoomName(
      {required this.screenWidth,
      required this.screenHeight,
      required this.color,
      required this.roomName})
      : super();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: screenHeight * 0.28,
      width: screenWidth,
      child: Center(
        child: Transform.rotate(
          angle: -1.58,
          child: Text(
            roomName.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
