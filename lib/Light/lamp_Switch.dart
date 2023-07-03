import 'package:flutter/material.dart';
import 'package:home_automation_project/Light/Light_Screen.dart';

class LampSwitch extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSwitchOn;
  final Color toggleOnColor, toggleOffColor, color;
  final screenWidth, screenHeight;
  final Duration animationDuration;

  const LampSwitch({
    required this.onTap,
    required this.isSwitchOn,
    this.screenWidth,
    this.screenHeight,
    required this.animationDuration,
    required this.toggleOnColor,
    required this.toggleOffColor,
    required this.color,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: screenHeight * 0.31,
      width: 30,
      left: screenWidth * 0.5 - 15,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: animationDuration,
              width: 30,
              height: 70,
              decoration: BoxDecoration(
                color: isSwitchOn ? bulbOnColor : bulbOffColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            AnimatedPositioned(
              duration: animationDuration,
              left: 0,
              right: 0,
              top: isSwitchOn ? 42 : 4,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
