import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/list_item_functions.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoContainer extends StatefulWidget {
  final String title;
  final String path;
  final String splittitle;
  final int index;
  const VideoContainer(
      {super.key,
      required this.title,
      required this.path,
      required this.splittitle,
      required this.index});

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;
  Duration _duration = const Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));
    _controller.initialize().then((_) {
      setState(() {
        _duration = _controller.value.duration;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () {
            playVideo(
                videotitle: widget.title,
                context: context,
                videoPath: widget.path,
                splittedvideotitle: widget.splittitle,
                recentduration: null);
          },
          leading: thumbnail(),
          title: Text(allVideos.value[widget.index].toString().split("/").last),
          subtitle: Text("${_duration.toString().split(".").first}\n$fileSize"),
          trailing: popupMenu(
              index: widget.index,
              title: widget.title,
              videoPath: widget.path)),
    );
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.path).lengthSync();
    if (fileSizeInBytes < 1024) {
      return '$fileSizeInBytes bytes';
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
