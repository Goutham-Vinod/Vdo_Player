import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class ChangeOrientationButton extends StatelessWidget {
  const ChangeOrientationButton({
    super.key,
    
    required this.size,
    required this.topPos,
    required this.leftPos,
  });

 
  final double size;
  final double topPos;
  final double leftPos;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: topPos,
        left: leftPos,
        child: IconButton(
            onPressed: () {
              VideoControllerFunctions.changeOrientation();
            },
            icon: Icon(
              Icons.screen_rotation,
              color: Colors.white,
              size: size,
            )));
  }
}
