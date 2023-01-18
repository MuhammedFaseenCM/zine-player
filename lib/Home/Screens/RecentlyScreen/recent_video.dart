import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recently_screen.dart';
import 'package:zineplayer/functions/functions.dart';

class RecentVideo extends StatefulWidget {
  final String title;
  final String path;
  final int durinSec;
  final double percent;
  final String splittitle;
  final int duration;
  final int index;
  const RecentVideo(
      {super.key,
      required this.title,
      required this.path,
      required this.durinSec,
      required this.percent,
      required this.splittitle,
      required this.duration,
      required this.index});

  @override
  State<RecentVideo> createState() => _RecentVideoState();
}

class _RecentVideoState extends State<RecentVideo> {
  @override
  void initState() {
    super.initState();
    // getthumbnail(widget.path, setState);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Card(
        child: ListTile(
          onTap: () {
            playVideo(
                videotitle: widget.title,
                context: context,
                videoPath: widget.path,
                splittedvideotitle: widget.splittitle,
                durationinSec: widget.durinSec);
          },
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              thumbnail(
                  duration: convertSecond(widget.duration), path: widget.path),
              SizedBox(
                  width: 110.0,
                  child: LinearPercentIndicator(
                    percent: widget.percent,
                    backgroundColor: grey,
                  ))
            ],
          ),
          title: Text(widget.splittitle,
              style: const TextStyle(fontWeight: FontWeight.normal)),
          trailing: popupMenu(
              index: widget.index,
              title: widget.title,
              videoPath: widget.path,
              fileSize: fileSize,
              duration: convertSecond(widget.duration),
              context: context),
        ),
      ),
    );
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.path).lengthSync();
    return filesizing(fileSizeInBytes);
  }
}
