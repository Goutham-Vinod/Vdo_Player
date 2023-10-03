import 'package:flutter/material.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/back_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/change_orientation_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/controller_shadows.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/lock_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/next_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/play_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/previous_button.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/custom_video_controller_widgets/seek_bar.dart';
import 'package:vdo_player/views/screens/video_player/custom_video_controller/video_controller_functions.dart';

class CustomLandscapeVideoController extends StatelessWidget {
  const CustomLandscapeVideoController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        //

        // All controllers (buttons,shadows.etc) except lock button

        //

        Stack(
          children: [
            ValueListenableBuilder(
              valueListenable: VideoControllerFunctions
                  .videoPlayerControlsVisibilityNotifier,
              builder: (context, videoPlayerControlsVisibility, child) {
                return Visibility(
                    visible: videoPlayerControlsVisibility,
                    child: Stack(
                      children: [
                        ControllerShadows(width: width, height: height),
                        CustomBackButton(
                            leftPos: width * 0.015, topPos: height * 0.05),
                        CustomSeekBar(
                          width: width,
                          seekBarTopPos: height * 0.78,
                          seekBarLeftPos: width * 0.04,
                          currentDurstionTopPos: height * 0.82,
                          currentDurationLeftPos: width * 0.02,
                          totalDurationTopPos: height * 0.82,
                          totalDurationLeftPos: width * 0.95,
                        ),
                        CustomPlayButton(
                          size: width * 0.05,
                          width: width,
                          topPos: height * 0.85,
                          leftPos: width * 0.46,
                        ),
                        CustomNextButton(
                          size: width * 0.05,
                          width: width,
                          topPos: height * 0.85,
                          leftPos: width * 0.56,
                        ),
                        CustomPreviousButton(
                          size: width * 0.05,
                          width: width,
                          topPos: height * 0.85,
                          leftPos: width * 0.36,
                        ),
                        ChangeOrientationButton(
                          size: width * 0.030,
                          topPos: height * 0.865,
                          leftPos: width * 0.02,
                        ),
                      ],
                    ));
              },
            )
          ],
        ),

        //

        // lock button

        //

        CustomLockButton(
          height: height,
          width: width,
          topPos: height * 0.865,
          leftPos: width * 0.94,
          topPosFullscreen: height * 0.15,
          leftPosFullscreen: width * 0.015,
          size: width * 0.035,
        ),
      ],
    );
  }
}
