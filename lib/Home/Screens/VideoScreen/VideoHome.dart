import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/VideoScreen.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/Home/Screens/VideoScreen/VideoContainer.dart';
import 'package:zineplayer/functions/datamodels.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                if (title.length > 25) {
                  splittitle = "${title.substring(0, 25)}...";
                }
                return VideoContainer(
                    index: index,
                    path: path,
                    splittitle: splittitle,
                    title: title);
              });
        },
      ),
    );
  }
}
