import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/AccessFolders/loadVideos.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/VideoScreen.dart';

class VideoList extends StatefulWidget {
  String folderPath;
  VideoList({super.key, required this.folderPath});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoPlayerController _controller;
  late File video;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadVideos(widget.folderPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.folderPath.split('/').last),
      ),
      body: ValueListenableBuilder(
        valueListenable: folderVideos,
        builder: (context, List<dynamic> videos, child) {
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              String videotitle = videos[index].toString().split("/").last;
              video = File(videos[index].toString());
              String splittedvideotitle = videotitle;
              if (splittedvideotitle.length > 20) {
                splittedvideotitle =
                    "${splittedvideotitle.substring(0, 20)}...";
              }
              _controller = VideoPlayerController.file(video);

              return Container(
                height: 100.0,
                child: Card(
                  child: ListTile(
                    onTap: () {
                      addToRecentList(title: videotitle, context: context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return VideoScreen(
                            videoFile: video,
                            videotitle: splittedvideotitle,
                          );
                        },
                      ));
                      SystemChrome.setEnabledSystemUIMode(
                          SystemUiMode.immersive);
                    },
                    isThreeLine: true,
                    leading: Column(
                      children: [
                        Icon(
                          Icons.movie_filter,
                          size: 30.0,
                        ),
                        Text("$videoDuration")
                      ],
                    ),
                    title: Text(splittedvideotitle),
                    subtitle: Text(
                        "Duration : ${_controller.value.duration.toString().split('.').first}"),
                    trailing: popupMenu(index: index, title: videotitle),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String get videoDuration {
    if (_controller.value.isInitialized) {
      final duration = _controller.value.duration;
      final minutes = duration.inMinutes.toString().padLeft(2, '0');
      final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
    return '00:00';
  }

  String get fileSize {
    final fileSizeInBytes = video.lengthSync();
    if (fileSizeInBytes < 1024) {
      return '${fileSizeInBytes} bytes';
    }
    if (fileSizeInBytes < 1048576) {
      return '${(fileSizeInBytes / 1024).toStringAsFixed(1)} KB';
    }
    if (fileSizeInBytes < 1073741824) {
      return '${(fileSizeInBytes / 1048576).toStringAsFixed(1)} MB';
    }
    return '${(fileSizeInBytes / 1073741824).toStringAsFixed(1)} GB';
  }

  Widget popupMenu({required index, required title}) {
    //  playScreen playscreen = playScreen();
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            addToFavourite(title: title, context: context);
            print(index);
          },
          icon: const Icon(Icons.favorite),
          label: const Text(
            "Add to favourite",
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
