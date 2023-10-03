
import 'package:flutter/material.dart';

class ControllerShadows extends StatelessWidget {
  const ControllerShadows({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [Positioned(
      // Dark Shade at Bottom
      bottom: 0,
      left: 0,
      child: Container(
        width: width,
        height: height * 0.3,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(0, 0, 0, 0),
            ])),
      )),
            Positioned(
      // Dark Shade at top
      top: 0,
      left: 0,
      child: Container(
        width: width,
        height: height * 0.35,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromARGB(0, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
            ])),
      )),],);
  }
}
