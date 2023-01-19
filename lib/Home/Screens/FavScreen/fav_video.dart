import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screen%20widgets/thumbnail_widget.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class FavouriteVideo extends StatefulWidget {
  final String title;
  final String path;
  final String trimtitle;
  final int index;
  final String duration;
  const FavouriteVideo(
      {super.key,
      required this.title,
      required this.path,
      required this.trimtitle,
      required this.index,
      required this.duration});

  @override
  State<FavouriteVideo> createState() => _FavouriteVideoState();
}

class _FavouriteVideoState extends State<FavouriteVideo> {
  int? durationinSecs = 0;

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

  @override
  void initState() {
    super.initState();
    recentdbdata();
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
              splittedvideotitle: widget.trimtitle,
              durationinSec: durationinSecs);
        },
        leading: thumbnail(duration: widget.duration, path: widget.path),
        title: Text(widget.trimtitle,
            style: const TextStyle(fontWeight: FontWeight.normal)),
        trailing: popupMenu(
            index: widget.index,
            title: widget.title,
            videoPath: widget.path,
            fileSize: fileSize,
            duration: widget.duration,
            isFav: false,
            context: context),
      ),
    );
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.path).lengthSync();
    return filesizing(fileSizeInBytes);
  }
}
