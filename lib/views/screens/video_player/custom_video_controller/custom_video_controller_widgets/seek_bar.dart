import 'package:flutter/material.dart';

import '../video_controller_functions.dart';

class CustomSeekBar extends StatelessWidget {
  const CustomSeekBar({
    super.key,
   
    required this.width,
    required this.seekBarTopPos,
    required this.seekBarLeftPos,
    required this.currentDurstionTopPos,
    required this.currentDurationLeftPos,
    required this.totalDurationLeftPos,
    required this.totalDurationTopPos,
  });

  
  final double width;
  final double seekBarTopPos;
  final double seekBarLeftPos;
  final double currentDurstionTopPos;
  final double currentDurationLeftPos;
  final double totalDurationTopPos;
  final double totalDurationLeftPos;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: seekBarTopPos,
            left: seekBarLeftPos,
            child: ValueListenableBuilder(
              valueListenable: VideoControllerFunctions.sliderValueNotifier,
              builder: (context, sliderValue, child) {
                return SizedBox(
                  width: width * 0.92,
                  child: Slider(
                      value: sliderValue.toDouble(),
                      min: 0,
                      max: VideoControllerFunctions.getTotalDuration!.inSeconds
                          .toDouble(),
                      thumbColor: Colors.purple,
                      activeColor: Colors.purple,
                      inactiveColor: const Color.fromARGB(103, 255, 255, 255),
                      onChanged: (value) {
                        VideoControllerFunctions.seekVideo(
                            Duration(seconds: value.toInt()));
                        print(value);
                      }),
                );
              },
            )),
        Positioned(
            // current duration
            top: currentDurstionTopPos,
            left: currentDurationLeftPos,
            child: const Text(
              '00:00',
              style: TextStyle(color: Colors.white),
            )),
        Positioned(
            // total duration
            top: totalDurationTopPos,
            left: totalDurationLeftPos,
            
            child: const Text(
              '00:00',
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}
