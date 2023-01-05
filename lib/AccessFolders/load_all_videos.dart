import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';

ValueNotifier<List<String>> allVideos = ValueNotifier([]);
List<String> aLLvideoList = [];

Future loadVideoList() async {
  allVideos.value.clear();
  allVideos.value = accessVideosPath.toList();
}
