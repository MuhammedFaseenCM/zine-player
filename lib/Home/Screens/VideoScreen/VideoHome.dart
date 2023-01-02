import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/VideoScreen.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoHome extends StatefulWidget {
  const VideoHome({super.key});

  @override
  State<VideoHome> createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
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
                String path = allVideos.value[index];
                String splittitle = title;
                if (title.length > 25) {
                  splittitle = "${title.substring(0, 25)}...";
                }
                return Card(
                  child: ListTile(
                      onTap: () {
                        playVideo(
                            videotitle: title,
                            context: context,
                            videoPath: path,
                            splittedvideotitle: splittitle);
                      },
                      leading: thumbnail(),
                      title: Text(
                          allVideos.value[index].toString().split("/").last),
                      trailing: popupMenu(
                          index: index, title: title, videoPath: path)),
                );
              });
        },
      ),
    );
  }

  Widget popupMenu({required index, required title, required videoPath}) {
    //  playScreen playscreen = playScreen();
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            addToFavourite(
                title: title, context: context, videoPath: videoPath);
            print(index);
            print(videoPath);
          },
          icon: const Icon(Icons.favorite),
          label: const Text(
            "Like",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        )),
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            addToPlayList(
                context: context, listIndex: index, videotitle: title);
            print(index);
            //Navigator.of(context).pop();
          },
          icon: const Icon(Icons.playlist_add),
          label: const Text(
            "Add to playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }

  void addToPlayList(
      {required BuildContext context,
      required listIndex,
      required videotitle}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Select playlist"),
          content:
              playlistDailog(listIndex: listIndex, videotitle: videotitle)),
    );
  }

  Widget playlistDailog({required listIndex, required videotitle}) {
    return Container(
      height: 150.0,
      width: 200.0,
      color: Colors.purple,
      child: ValueListenableBuilder(
        valueListenable: playListNotifier,
        builder:
            (BuildContext context, List<PlayList> playlist, Widget? child) {
          return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final listdata = playlist[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      addItemToPlayList(title: videotitle, context: context);
                      snackBar(
                          context: context,
                          content: 'Successfully added',
                          bgcolor: Colors.green);
                    },
                    title: Text(listdata.name),
                  ),
                );
              },
              itemCount: playlist.length);
        },
      ),
    );
  }
}
