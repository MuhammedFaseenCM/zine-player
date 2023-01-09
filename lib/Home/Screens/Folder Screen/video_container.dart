import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';
import 'package:zineplayer/functions/functions.dart';

class FolderVideoContainer extends StatefulWidget {
  final String videoPath;
  final int index;
  final String videotitle;
  final String splittitle;
  const FolderVideoContainer(
      {super.key,
      required this.videoPath,
      required this.index,
      required this.videotitle,
      required this.splittitle});

  @override
  State<FolderVideoContainer> createState() => _FolderVideoContainerState();
}

class _FolderVideoContainerState extends State<FolderVideoContainer> {
  late VideoPlayerController _controller;
  Duration _duration = const Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath));
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
              videotitle: widget.videotitle,
              context: context,
              videoPath: widget.videoPath,
              splittedvideotitle: widget.splittitle,
              durationinSec: 0);
          //  print("videos[index] : " + videos[index]);
        },
        //  isThreeLine: true,
        leading: thumbnail(duration: _duration.toString().split(".").first),
        title: Text(widget.splittitle),
        // subtitle: Text("${_duration.toString().split(".").first}\n$fileSize"),
        trailing: popupMenu(
            index: widget.index,
            title: widget.videotitle,
            videoPath: widget.videoPath),
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
    final fileSizeInBytes = File(widget.videoPath).lengthSync();
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
}

Widget popupMenu({required index, required title, required videoPath}) {
  return PopupMenuButton(
    itemBuilder: (context) => [
      PopupMenuItem(
          child: TextButton.icon(
        onPressed: () {
          addToFavourite(title: title, context: context, videoPath: videoPath);
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
          addToPlayList(context: context, widgetpath: videoPath);
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
