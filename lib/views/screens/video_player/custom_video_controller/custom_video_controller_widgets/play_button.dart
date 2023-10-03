import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class CustomPlayButton extends StatelessWidget {
  const CustomPlayButton({
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
    return ValueListenableBuilder(
      valueListenable: VideoControllerFunctions.isVideoPlayingNotifier,
      builder: (context, isVideoPlaying, child) {
        return Positioned(
            top: topPos,
            left: leftPos,
            child: IconButton(
                onPressed: () {
                  VideoControllerFunctions.pausePlayVideo();
                },
                icon: isVideoPlaying == true
                    ? Icon(
                        size: size,
                        Icons.pause,
                        color: Colors.white,
                      )
                    : Icon(
                        size: size,
                        Icons.play_arrow,
                        color: Colors.white,
                      )));
      },
    );
  }
}
