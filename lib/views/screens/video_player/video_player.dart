import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_landscape_video_controller_ui.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_portrait_video_controller_ui.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({required this.videoPaths, this.startIndex, super.key});

  final List<String> videoPaths;
  final int? startIndex;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  BoxFit videoBoxFit = BoxFit.contain;

  @override
  void initState() {
    // Initializing video player
    VideoControllerFunctions.setVideoPaths(
      videoPaths: widget.videoPaths,
      startIndex: widget.startIndex,
    );

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    VideoControllerFunctions.disposeController();

    // flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleUpdate: (details) {
        if (details.scale > 1.5) {
          setState(() {
            videoBoxFit = BoxFit.cover;
          });
        }
        if (details.scale < 0.5) {
          setState(() {
            videoBoxFit = BoxFit.contain;
          });
        }
      },
      onDoubleTap: () {
        VideoControllerFunctions.showFullScreenControls();
      },
      onTap: () {
        if (!VideoControllerFunctions.isFullScreenMode) {
          VideoControllerFunctions.showControls();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: VideoControllerFunctions.flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                controls: const SizedBox(),
                videoFit: videoBoxFit,
              ),
              wakelockEnabled: true,
              preferredDeviceOrientation: const [
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft
              ],
            ),
            ValueListenableBuilder(
              valueListenable:
                  VideoControllerFunctions.currentScreenOrientationsNotifier,
              builder: (context, currentScreenOrientation, child) {
                if (currentScreenOrientation.first ==
                    DeviceOrientation.portraitUp) {
                  return const CustomPortraitVideoController();
                } else {
                  return const CustomLandscapeVideoController();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
