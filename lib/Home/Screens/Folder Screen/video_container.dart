import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';
import 'package:zineplayer/Home/Screens/videoscreen/video_container.dart';
import 'package:zineplayer/functions/datamodels.dart';
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
  int? durationinSecs = 0;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _controller.initialize().then((_) {
      setState(() {
        _duration = _controller.value.duration;
      });
    });
    recentdbdata();
    getthumbnail(widget.videoPath, setState);
  }

  recentdbdata() async {
    final box = await Hive.openBox<RecentList>('recentlistBox');
    List<RecentList> data = box.values.toList();
    List<RecentList> result = data
        .where((contains) => contains.videoPath == widget.videoPath)
        .toList();
    if (result.isNotEmpty) {
      durationinSecs = result
          .where((element) => element.videoPath == widget.videoPath)
          .first
          ?.durationinSec;
    }
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
        title: widget.videotitle,
        splittitle: widget.splittitle,
        path: widget.videoPath,
        duration: _duration,
        durinsec: durationinSecs);
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.videoPath).lengthSync();
    return filesizing(fileSizeInBytes);
  }
}

String filesizing(fileSizeInBytes) {
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

bool isFav = false;
isFavCheck(videoPath) async {
  final favouritehive = await Hive.openBox<Favourite>('favouriteBox');
  List<Favourite> favListing = favouritehive.values.toList();
  List<Favourite> result =
      favListing.where((contains) => contains.videoPath == videoPath).toList();
  if (result.isEmpty) {
    isFav = false;
  } else {
    isFav = true;
  }
}
