import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    required this.topPos,
    required this.leftPos,
  });

  final double topPos;
  final double leftPos;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: topPos,
        left: leftPos,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )));
  }
}
