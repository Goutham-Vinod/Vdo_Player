import 'package:flutter/material.dart';

import '../video_controller_functions.dart';

class CustomSeekBar extends StatelessWidget {
  const CustomSeekBar({
    super.key,
    required this.sliderWidth,
    required this.seekBarTopPos,
    required this.seekBarLeftPos,
    required this.currentDurationTopPos,
    required this.currentDurationLeftPos,
    required this.totalDurationLeftPos,
    required this.totalDurationTopPos,
  });

  final double sliderWidth;
  final double seekBarTopPos;
  final double seekBarLeftPos;
  final double currentDurationTopPos;
  final double currentDurationLeftPos;
  final double totalDurationTopPos;
  final double totalDurationLeftPos;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: VideoControllerFunctions.seekBarValueNotifier,
      builder: (context, seekBarValue, child) {
        // seekBarValue = completed video duration in seconds
        double totalDuration =
            VideoControllerFunctions.getTotalDuration!.inSeconds.toDouble();

        String totalVideoDuration = getFormattedString(totalDuration.toInt());
        String completedVideoDuration = getFormattedString(seekBarValue);

        return Stack(
          children: [
            Positioned(
                top: seekBarTopPos,
                left: seekBarLeftPos,
                child: SizedBox(
                  width: sliderWidth,
                  child: Slider(
                      value: seekBarValue.toDouble(),
                      min: 0,
                      max: totalDuration,
                      thumbColor: Colors.purple,
                      activeColor: Colors.purple,
                      inactiveColor: const Color.fromARGB(103, 255, 255, 255),
                      onChanged: (value) {
                        VideoControllerFunctions.seekVideo(
                            Duration(seconds: value.toInt()));
                      }),
                )),
            Positioned(
                // current duration
                top: currentDurationTopPos,
                left: currentDurationLeftPos,
                child: Text(
                  completedVideoDuration,
                  style: const TextStyle(color: Colors.white),
                )),
            Positioned(
                // total duration
                top: totalDurationTopPos,
                left: totalDurationLeftPos,
                child: Text(
                  totalVideoDuration,
                  style: const TextStyle(color: Colors.white),
                )),
          ],
        );
      },
    );
  }

  String getFormattedString(int seconds) {
    int min = (seconds ~/ 60);
    int sec = (seconds % 60);

    String minString = min.toString().padLeft(2, '0');
    String secString = sec.toString().padLeft(2, '0');

    return '$minString:$secString';
  }
}
