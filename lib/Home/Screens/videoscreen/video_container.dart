import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/video_container.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';
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
              //  durationinSec: widget.durationinSec
            );
          },
          leading: thumbnail(duration: _duration.toString().split(".").first),
          title: Text(widget.splittitle),
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
}
