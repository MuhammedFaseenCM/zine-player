import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/AccessFolders/loadVideos.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
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
  late VideoPlayerController _controller;
  late File video;

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
    _controller.dispose();
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
              video = File(videos[index].toString());
              String splittedvideotitle = videotitle;
              if (splittedvideotitle.length > 25) {
                splittedvideotitle =
                    "${splittedvideotitle.substring(0, 25)}...";
              }
              _controller = VideoPlayerController.file(video);
              _controller.initialize();
              VideoList.length = videos.length;
              return Container(
                height: 100.0,
                child: Card(
                  child: ListTile(
                    onTap: () {
                      playVideo(
                          videotitle: videotitle,
                          context: context,
                          videoPath: videos[index],
                          splittedvideotitle: splittedvideotitle);
                      print("videos[index] : " + videos[index]);
                    },
                    isThreeLine: true,
                    leading: const Icon(
                      Icons.movie_filter,
                      size: 50.0,
                    ),
                    title: Text(splittedvideotitle),
                    subtitle: Text(
                        _controller.value.duration.toString().split('.').first),
                    trailing: popupMenu(
                        index: index,
                        title: videotitle,
                        videoPath: videos[index]),
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
