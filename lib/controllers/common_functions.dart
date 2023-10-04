import 'dart:developer';

import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

searchFromStringList(String query, stringList) {
  List<String> suggestions = stringList.where((stringElement) {
    String findString = query.toLowerCase().trim();
    final mainString = stringElement.toString().toLowerCase();
    return mainString.contains(findString);
  }).toList();

  return suggestions;
}

String truncateWithEllipsis(int cutoff, String myString) {
  return (myString.length <= cutoff)
      ? myString
      : '${myString.substring(0, cutoff)}...';
}

findUniqueFiles(List<String> videos) {
  List<String> uniqueFiles = videos.toSet().toList();
  return uniqueFiles;
}

findFileName(filePath) {
  String fileName = filePath.split('/').last;
  return fileName;
}

findUniqueFolders(List<String> videos) {
  List<String> uniqueFolders = [];
  List<String> folders = findFolders(videos);
  uniqueFolders = folders.toSet().toList();
  return uniqueFolders;
}

findFolders(List<String> videos) {
  List<String> folders = [];
  for (int i = 0; i < videos.length; i++) {
    folders.add(findFolderPath(videos[i]));
  }
  return folders;
}

findFolderPath(video) {
  String folderPath = "";
  List<String> folders = video.split('/');
  String folderName = video.split('/')[folders.length - 2];

  for (int i = 0; i < folders.length; i++) {
    String folder = folders[i];

    if (folder != folderName) {
      folderPath += "$folder/";
    } else {
      break;
    }
  }
  folderPath += folderName;
  return folderPath;
}

findFolderName(folderPath) {
  String folderName = folderPath.split('/').last;
  return folderName;
}

Future getVideoInfo(videoPath) async {
  final videoInfo = FlutterVideoInfo();
  double milliseconds = 0;
  try {
    var info = await videoInfo.getVideoInfo(videoPath);
    milliseconds = info?.duration ?? 0;
  } catch (e) {
    log(e.toString());
  }
  return milliseconds;
}

Future<String> generateThumb(path) async {
  String thumbFile = 'null';
  try {
    thumbFile = (await VideoThumbnail.thumbnailFile(
            timeMs: 130,
            maxWidth: 0,
            video: "/$path",
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.PNG))
        .toString();
  } catch (e) {}

  return thumbFile;
}
