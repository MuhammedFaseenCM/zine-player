import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/popup_widget.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayListVideo extends StatefulWidget {
  final String title;
  final String videoPath;
  final String shorttitle;
  final int index;
  final String duration;
  const PlayListVideo(
      {super.key,
      required this.title,
      required this.videoPath,
      required this.shorttitle,
      required this.index,
      required this.duration});

  @override
  State<PlayListVideo> createState() => _PlayListVideoState();
}

class _PlayListVideoState extends State<PlayListVideo> {
  int? durationinSecs = 0;

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
  void initState() {
    super.initState();
    recentdbdata();
    getthumbnail(widget.videoPath, setState);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          playVideo(
              videotitle: widget.title,
              context: context,
              videoPath: widget.videoPath,
              splittedvideotitle: widget.shorttitle,
              durationinSec: durationinSecs);
        },
        leading: thumbnail(duration: widget.duration),
        title: Text(widget.shorttitle),
        trailing: popupMenu(
            index: widget.index,
            title: widget.title,
            fileSize: "",
            videoPath: widget.videoPath,
            duration: widget.duration,
            isPlaylist: false,context: context),
      ),
    );
  }

}
