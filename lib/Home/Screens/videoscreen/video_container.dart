import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';


class VideoContainer extends StatefulWidget {
  final String title;
  final String path;
  final String splittitle;
  final int index;
  final String duration;

  const VideoContainer({
    super.key,
    required this.title,
    required this.path,
    required this.splittitle,
    required this.index,
    required this.duration,
  });

  @override
  State<VideoContainer> createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  int? durationinSecs = 0;

  @override
  void initState() {
    super.initState();
    //getthumbnail(widget.path, setState);
    recentdbdata();
  }

  @override
  void dispose() {
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
      duration: widget.duration,
      durinsec: durationinSecs,
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

  recentdbdata() async {
    final box = await Hive.openBox<RecentList>('recentlistBox');
    List<RecentList> data = box.values.toList();
    List<RecentList> result =
        data.where((contains) => contains.videoPath == widget.path).toList();
    if (result.isNotEmpty) {
      durationinSecs = result
          .where((element) => element.videoPath == widget.path)
          .first
          ?.durationinSec;
    }
  }
}

Widget listTileVideo({
  required index,
  required fileSize,
  required context,
  required title,
  required splittitle,
  required path,
  required duration,
  required durinsec,
}) {
  
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
      leading:
          thumbnail(duration: duration.toString().split(".").first, path: path),
      title: Text(splittitle,
          style: const TextStyle(fontWeight: FontWeight.normal)),
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
