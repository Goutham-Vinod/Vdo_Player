import 'dart:async';
import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoControllerFunctions {
  //

  // -----------------   Variables -------------------------------

  //
  static late VideoPlayerController videoPlayerController;
  static late FlickManager flickManager;
  static bool isFullScreenMode = false;
  static DateTime?
      _lastUserInterationTime; // currentTime -  _lastUserInteractionTime = idleTime duration
  static Duration? currentPosition; // current Video position
  static List<String> videoPaths = [];
  static int currentVideoIndex = 0;

  static ValueNotifier<List<DeviceOrientation>>
      currentScreenOrientationsNotifier =
      ValueNotifier([DeviceOrientation.portraitUp]);
  static ValueNotifier<int> seekBarValueNotifier = ValueNotifier<int>(0);
  // seekBarValue = completed video duration in seconds
  static ValueNotifier<bool> videoPlayerControlsVisibilityNotifier =
      ValueNotifier<bool>(true);
  static ValueNotifier<bool> isVideoPlayingNotifier = ValueNotifier<bool>(true);
  static ValueNotifier<bool> lockButtonVisibilityNotifier =
      ValueNotifier<bool>(true);

  //

  // -----------------  Functions ----------------------

  //

  static setVideoPaths({required List<String> videoPaths, int? startIndex}) {
    // Video player initialization
    isVideoPlayingNotifier.value = true;
    seekBarValueNotifier.value = 0;

    if (startIndex != null) {
      currentVideoIndex = startIndex;
    }

    // setting video path to video Controllers
    videoPlayerController =
        VideoPlayerController.file(File(videoPaths[currentVideoIndex]));
    flickManager = FlickManager(
      videoPlayerController: videoPlayerController,
    );

    // showing custom controllers
    showControls();
    markUserInteraction();
    flickManager.onVideoEnd = () {
      // if its the last video then stop video player else play next video
      if (currentVideoIndex == videoPaths.length - 1) {
        isVideoPlayingNotifier.value = false;
      } else {
        playNextVideo();
      }

      print('Video ended');
    };

    // to start updating current watch duration
    updateCurrentPosition();
  }

  static markUserInteraction() {
    // _last user interaction time was updated to keep a track of device idle time
    // helps to hide controllers automatically after the waitSeconds.
    _lastUserInterationTime = DateTime.now();
  }

  static updateCurrentPosition() async {
    while (isVideoPlayingNotifier.value == true) {
      await Future.delayed(const Duration(milliseconds: 500));
      Duration? currentPosition =
          flickManager.flickVideoManager?.videoPlayerValue?.position;
      seekBarValueNotifier.value = currentPosition!.inSeconds;
    }
  }

  static showControls() async {
    markUserInteraction();
    const int waitSeconds = 5;

    videoPlayerControlsVisibilityNotifier.value = true;
    lockButtonVisibilityNotifier.value = true;

    while (!isFullScreenMode) {
      await Future.delayed(const Duration(seconds: 1));
      int idleTimeSeconds =
          DateTime.now().difference(_lastUserInterationTime!).inSeconds;

      if (idleTimeSeconds > waitSeconds) {
        videoPlayerControlsVisibilityNotifier.value = false;
        lockButtonVisibilityNotifier.value = false;

        break;
      }
    }
  }

  static showFullScreenControls() async {
    markUserInteraction();
    const int waitSeconds = 2;

    lockButtonVisibilityNotifier.value = true;

    while (isFullScreenMode) {
      await Future.delayed(const Duration(seconds: 1));
      int idleTimeSeconds =
          DateTime.now().difference(_lastUserInterationTime!).inSeconds;

      if (idleTimeSeconds > waitSeconds) {
        lockButtonVisibilityNotifier.value = false;

        break;
      }
    }
  }

  static pausePlayVideo() {
    markUserInteraction();
    if (isVideoPlayingNotifier.value == true) {
      flickManager.flickControlManager?.pause();
      isVideoPlayingNotifier.value = false;
    } else {
      flickManager.flickControlManager?.play();
      isVideoPlayingNotifier.value = true;
      updateCurrentPosition();
    }
  }

  static seekVideo(Duration moment) {
    markUserInteraction();

    seekBarValueNotifier.value = moment.inSeconds;
    flickManager.flickControlManager?.seekTo(moment);
  }

  static Duration? get getTotalDuration {
    return flickManager.flickVideoManager?.videoPlayerValue?.duration;
  }

  static muteVideo() {
    markUserInteraction();
  }

  static unMuteVideo() {
    markUserInteraction();
  }

  static playNextVideo() {
    markUserInteraction();
  }

  static playPreviousVideo() {
    markUserInteraction();
  }

  static enterFullScreenMode() {
    isFullScreenMode = true;
    markUserInteraction();
    // To hide video player controls
    videoPlayerControlsVisibilityNotifier.value = false;
    lockButtonVisibilityNotifier.value = false;

    // To hide status bar and bottom navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static exitFullScreenMode() {
    isFullScreenMode = false;
    markUserInteraction();
    // To show video player controls
    showControls();

    //To show the status bar and Bottom navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, // bottom navigation bar
      SystemUiOverlay.top, // status bar
    ]);
  }

  static changeOrientation() {
    if (currentScreenOrientationsNotifier.value.first ==
        DeviceOrientation.portraitUp) {
      setLandscapeOrientation();
    } else {
      setPortraitOrientation();
    }
  }

  static setPortraitOrientation() {
    currentScreenOrientationsNotifier.value = [DeviceOrientation.portraitUp];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  static setLandscapeOrientation() {
    currentScreenOrientationsNotifier.value = [
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static disposeController() {
    print('dispose called');
    flickManager.dispose();
  }
}
