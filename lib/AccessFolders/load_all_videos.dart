import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recently_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/main.dart';

ValueNotifier<List<String>> allVideos = ValueNotifier([]);
List<AllVideos> aLLvideoList = [];
final videoInfo = FlutterVideoInfo();
Future loadVideoList() async {
  if (videoDB.isEmpty || videoDB.length != accessVideosPath.length) {
    videoDB.clear();
    AllVideos videosObj;
    for (var i = 0; i < accessVideosPath.length; i++) {
      VideoData? info = await videoInfo.getVideoInfo(accessVideosPath[i]);
      double second = info!.duration! / 1000;
      String duration = convertSecond(second);

      videosObj = AllVideos(duration: duration,path: info!.path!);
      videoDB.add(videosObj);
    }
  }
  allVideos.value.clear();
  allVideos.value = accessVideosPath.toList();
}
