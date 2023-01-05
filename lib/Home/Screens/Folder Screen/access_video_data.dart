import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_videos.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/video_container.dart';
import 'package:zineplayer/Home/main_screen.dart';

class VideoList extends StatefulWidget {
  final String folderPath;
  static late int length;
  const VideoList({super.key, required this.folderPath});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {

  @override
  void initState() {

    super.initState();
    loadVideos(widget.folderPath);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.folderPath.split('/').last),
        flexibleSpace: appbarcontainer(),
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: folderVideos,
        builder: (context, List<dynamic> videos, child) {
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              String videotitle = videos[index].toString().split("/").last;
              //  video = File(videos[index].toString());
              String splittedvideotitle = videotitle;
              if (splittedvideotitle.length > 25) {
                splittedvideotitle =
                    "${splittedvideotitle.substring(0, 25)}...";
              }
              return FolderVideoContainer(
                  index: index,
                  videoPath: videos[index],
                  splittitle: splittedvideotitle,
                  videotitle: videotitle);
            },
          );
        },
      ),
    );
  }
}
