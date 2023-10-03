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

class CustomPortraitVideoController extends StatelessWidget {
  const CustomPortraitVideoController({super.key});

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
                          seekBarTopPos: height * 0.825,
                          seekBarLeftPos: width * 0.04,
                          currentDurstionTopPos: height * 0.845,
                          currentDurationLeftPos: width * 0.002,
                          totalDurationTopPos: height * 0.845,
                          totalDurationLeftPos: width * 0.905,
                        ),
                        CustomPlayButton(
                          size: width * 0.115,
                          width: width,
                          topPos: height * 0.895,
                          leftPos: width * 0.46,
                        ),
                        CustomNextButton(
                          size: width * 0.115,
                          width: width,
                          topPos: height * 0.895,
                          leftPos: width * 0.62,
                        ),
                        CustomPreviousButton(
                          size: width * 0.115,
                          width: width,
                          topPos: height * 0.895,
                          leftPos: width * 0.3,
                        ),
                        ChangeOrientationButton(
                          size: width * 0.070,
                          topPos: height * 0.905,
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
          topPos: height * 0.905,
          leftPos: width * 0.88,
          topPosFullscreen: height * 0.025,
          leftPosFullscreen: width * 0.015,
          size: width * 0.08,
        ),
      ],
    );
  }
}
