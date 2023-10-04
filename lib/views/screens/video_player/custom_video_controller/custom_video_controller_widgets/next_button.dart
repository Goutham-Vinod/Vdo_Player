import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class CustomNextButton extends StatelessWidget {
  const CustomNextButton({
    super.key,
    required this.size,
    required this.width,
    required this.topPos,
    required this.leftPos,
  });

  final double size;
  final double width;
  final double topPos;
  final double leftPos;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: topPos,
        left: leftPos,
        child: IconButton(
            onPressed: () {
              VideoControllerFunctions.playNextVideo();
            },
            icon: Icon(
              size: size,
              Icons.skip_next,
              color: Colors.white,
            )));
  }
}
