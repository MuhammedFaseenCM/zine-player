import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/AccessFolders/loadVideos.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/VideoContainer.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/Home/mainScreen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoList extends StatefulWidget {
  String folderPath;
  static late int length;
  VideoList({super.key, required this.folderPath});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
//  late File video;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideos(widget.folderPath);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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

              // Duration _duration = _controller.value.duration;

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
