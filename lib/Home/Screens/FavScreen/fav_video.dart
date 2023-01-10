import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class FavouriteVideo extends StatefulWidget {
  final String title;
  final String path;
  final String trimtitle;
  final int index;
  const FavouriteVideo(
      {super.key,
      required this.title,
      required this.path,
      required this.trimtitle,
      required this.index});

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
        leading: thumbnail(),
        title: Text(widget.trimtitle),
        trailing: popupMenu(widget.index),
      ),
    );
  }

  Widget popupMenu(index) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteFav(index);
            snackBar(
                context: context, content: "Unliked", bgcolor: Colors.green);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.remove, color: Colors.red),
          label: const Text(
            "Unlike",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }
}
