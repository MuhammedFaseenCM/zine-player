import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/Home/Screens/VideoScreen/Video_Container.dart';

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
