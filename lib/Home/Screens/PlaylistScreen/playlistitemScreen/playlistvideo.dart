import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayListVideo extends StatefulWidget {
  final String title;
  final String videoPath;
  final String shorttitle;
  final int index;
  const PlayListVideo(
      {super.key,
      required this.title,
      required this.videoPath,
      required this.shorttitle,
      required this.index});

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
    // TODO: implement initState
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
              videoPath: widget.videoPath,
              splittedvideotitle: widget.shorttitle,
              durationinSec: durationinSecs);
        },
        leading: thumbnail(),
        title: Text(widget.shorttitle),
        trailing: popupMenu(index: widget.index),
      ),
    );
  }

  Widget popupMenu({required index}) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteListItem(index: index, context: context);
            snackBar(
                context: context,
                content: "Successfully deleted",
                bgcolor: Colors.green);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          label: const Text(
            "Delete from playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }
}
