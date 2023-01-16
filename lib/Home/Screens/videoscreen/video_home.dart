import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_all_videos.dart';
import 'package:zineplayer/Home/Screens/videoscreen/video_container.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoHome extends StatefulWidget {
  const VideoHome({super.key});

  @override
  State<VideoHome> createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
  late String path;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: allVideos,
        builder: (context, dynamic videolist, child) {
          return ListView.builder(
              itemCount: videolist.length,
              itemBuilder: (context, index) {
                String title =
                    allVideos.value[index].toString().split("/").last;
                path = allVideos.value[index];
                String splittitle = title;
                if (title.length > 20) {
                  splittitle = "${title.substring(0, 20)}...";
                }

                return VideoContainer(
                    title: title,
                    path: path,
                    splittitle: splittitle,
                    index: index);
              });
        },
      ),
    );
  }
}
