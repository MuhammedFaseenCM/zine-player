import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';

ValueNotifier<List<String>> folderVideos = ValueNotifier([]);

loadVideos(String path) {
  folderVideos.value.clear();

  List<String> videoPath = [];
  List<String> splittedVideoPath = [];

  var splitted = path.split('/');

  for (var singlePath in accessVideosPath) {
    if (singlePath.startsWith(path)) {
      videoPath.add(singlePath);
    }
  }

  for (var newPath in videoPath) {
    splittedVideoPath = newPath.split('/');

    if (splittedVideoPath[splitted.length].endsWith('.mp4') ||
        splittedVideoPath[splitted.length].endsWith('.mkv')) {
      folderVideos.value.add(newPath);
    }
  }
}
