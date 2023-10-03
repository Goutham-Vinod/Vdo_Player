import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class CustomLockButton extends StatelessWidget {
  const CustomLockButton({
    super.key,
    required this.height,
    required this.width,
    required this.topPos,
    required this.leftPos,
    required this.topPosFullscreen,
    required this.leftPosFullscreen,
    required this.size,
  });

  final double height;
  final double width;
  final double topPos;
  final double leftPos;
  final double topPosFullscreen;
  final double leftPosFullscreen;
  final double size;

  // we need to specify fullscreen positions (video player lock)
  // and normal positions

  // pass those parameter according to screen mode (portrait/landscape)

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable:
              VideoControllerFunctions.lockButtonVisibilityNotifier,
          builder: (context, lockButtonVisibility, child) {
            if (VideoControllerFunctions.isFullScreenMode) {
              // lock button at full screen mode
              return Visibility(
                visible: lockButtonVisibility,
                child: Positioned(
                    top: topPosFullscreen,
                    left: leftPosFullscreen,
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(100, 0, 0, 0),
                          border: Border.all(
                              color: const Color.fromARGB(100, 255, 255, 255)),
                          borderRadius: BorderRadius.circular(5)),
                      child: IconButton(
                          onPressed: () {
                            VideoControllerFunctions.exitFullScreenMode();
                          },
                          icon: Icon(
                            size: size,
                            Icons.lock_outline,
                            color: Colors.white,
                          )),
                    )),
              );
            } else {
              // lock button at normal mode
              return Visibility(
                visible: lockButtonVisibility,
                child: Positioned(
                    top: topPos,
                    left: leftPos,
                    child: IconButton(
                        onPressed: () {
                          VideoControllerFunctions.enterFullScreenMode();
                        },
                        icon: Icon(
                          size: size,
                          Icons.lock_outline,
                          color: Colors.white,
                        ))),
              );
            }
          },
        ),
      ],
    );
  }
}
