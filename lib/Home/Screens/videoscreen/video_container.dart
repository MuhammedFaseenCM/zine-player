import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/popup_widget.dart';
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
  int? durationinSecs = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));
    _controller.initialize().then((_) {
      setState(() {
        _duration = _controller.value.duration;
      });
    });
    getthumbnail(widget.path, setState);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return listTileVideo(
        index: widget.index,
        fileSize: fileSize,
        context: context,
        title: widget.title,
        splittitle: widget.splittitle,
        path: widget.path,
        duration: _duration,
        durinsec: durationinSecs);
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

Widget listTileVideo(
    {required index,
    required fileSize,
    required context,
    required title,
    required splittitle,
    required path,
    required duration,
    required durinsec}) {
  return Card(
    child: ListTile(
      onTap: () {
        playVideo(
            videotitle: title,
            context: context,
            videoPath: path,
            splittedvideotitle: splittitle,
            durationinSec: durinsec);
      },
      leading: thumbnail(duration: duration.toString().split(".").first),
      title: Text(splittitle),
      trailing: popupMenu(
          index: index,
          title: title,
          videoPath: path,
          fileSize: fileSize,
          duration: duration.toString().split(".").first,
          context: context),
    ),
  );
}
